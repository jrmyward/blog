require 'rails_helper'
require 'ostruct'

RSpec.describe "ListSubscribers", type: :request do

  describe "POST confirm" do
    let(:subscriber) { create(:list_subscriber) }

    it "confirms a subscriber" do
      post "/subscribers/confirm?ocd=#{Rails.application.secrets.mail_chimp_webhook_token}", mailchimp_response_for(subscriber)
      expect(subscriber.reload.confirmed).to be true
    end

    it "silently handles bad data" do
      post "/subscribers/confirm?ocd=#{Rails.application.secrets.mail_chimp_webhook_token}", mailchimp_response_for(OpenStruct.new(email: 'parker@avengers.com', first_name: 'Peter'))
      expect(response.status).to be 422
    end

    it "silently handles a missing email" do
      post "/subscribers/confirm?ocd=#{Rails.application.secrets.mail_chimp_webhook_token}", {}
      expect(response.status).to be 417
    end

    it "silently handles unsoliceted requests" do
      post "/subscribers/confirm", mailchimp_response_for(subscriber)
      expect(response.status).to be 412
    end
  end

  describe "GET confirm" do
    it "simply returns a 200" do
      get "/subscribers/confirm"
      expect(response.status).to be 200
    end
  end

end

def mailchimp_response_for(subscriber)
  {
    "type" => "subscribe",
    "fired_at" => "2009-03-26 21:35:57",
    "data[id]" => "8a25ff1d98",
    "data[list_id]" => "a6b5da1054",
    "data[email]" => "#{subscriber.email}",
    "data[email_type]" => "html",
    "data[merges][EMAIL]" => "#{subscriber.email}",
    "data[merges][FNAME]" => "#{subscriber.first_name}",
    "data[merges][INTERESTS]" => "Group1,Group2",
    "data[ip_opt]" => "10.20.10.30",
    "data[ip_signup]" => "10.20.10.30"
  }
end