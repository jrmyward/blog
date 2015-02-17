require 'rails_helper'
require 'ostruct'

RSpec.describe NewsletterService, type: :model do
  let(:subscriber) { create(:list_subscriber) }
  let(:non_subscriber) { OpenStruct.new(email: '', first_name: '') }

  describe "#subscribe" do
    context "Success" do
      it "will return true" do
        VCR.use_cassette "newsletter/subscribe_success" do
          newsletter_service = NewsletterService.new
          expect(newsletter_service.subscribe(subscriber)).to_not be nil
        end
      end
    end

    context "Failure" do
      it "will return false" do
        VCR.use_cassette "newsletter/subscribe_failure" do
          newsletter_service = NewsletterService.new
          expect(newsletter_service.subscribe(non_subscriber)).to be false
        end
      end
    end
  end

end