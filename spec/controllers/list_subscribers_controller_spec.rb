require 'spec_helper'

describe ListSubscribersController do
  let(:valid_attributes) { attributes_for(:list_subscriber) }

  describe "GET new" do
    it "assigns a new list_subscriber as @list_subscriber" do
      get :new, {}
      expect(assigns(:list_subscriber)).to be_a_new(ListSubscriber)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      before(:each) do
        allow_any_instance_of(ListSubscriber).to receive(:subscribe_to_list).and_return(true)
      end

      it "creates a new ListSubscriber" do
        expect {
          post :create, {:list_subscriber => valid_attributes}
        }.to change(ListSubscriber, :count).by(1)
      end

      it "assigns a newly created list_subscriber as @list_subscriber" do
        post :create, {:list_subscriber => valid_attributes}
        expect(assigns(:list_subscriber)).to be_a(ListSubscriber)
        expect(assigns(:list_subscriber)).to be_persisted
      end

      it "redirects to the created list_subscriber" do
        post :create, {:list_subscriber => valid_attributes}
        expect(response).to redirect_to(posts_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved list_subscriber as @list_subscriber" do
        allow_any_instance_of(ListSubscriber).to receive(:save).and_return(false)
        post :create, {:list_subscriber => { "email" => "invalid value" }}
        expect(assigns(:list_subscriber)).to be_a_new(ListSubscriber)
      end

      it "re-renders the 'new' template" do
        post :create, {:list_subscriber => { "email" => "" }}
        expect(response).to render_template("new")
      end
    end
  end

  describe "POST confirm" do
    let(:list_subscriber) { create(:list_subscriber) }

    describe "with valid params" do
      it "Confirms the subscriber" do
        post :confirm, set_mailchimp_params(list_subscriber)
        expect(list_subscriber.reload.confirmed).to be true
      end

      it "Returns a 202" do
        post :confirm, set_mailchimp_params(list_subscriber)
        expect(response.status).to eq 202
      end
    end

    describe "with invalid params" do
      context "When the webhook is wrong" do
        it "returns a 412" do
          post :confirm, { ocd: "invalid" }
          expect(response.status).to eq 412
        end
      end

      context "When data is missing" do
        it "returns a 417" do
          post :confirm, { ocd: Rails.application.secrets.mail_chimp_webhook_token }
          expect(response.status).to eq 417
        end
      end

      context "When a subscriber is not found" do
        it "returns a 422" do
          post :confirm, set_mailchimp_params(build(:list_subscriber))
          expect(response.status).to eq 422
        end
      end

    end
  end

end

def set_mailchimp_params(subscriber)
  {
    "ocd"       => Rails.application.secrets.mail_chimp_webhook_token,
    "type"      => "subscribe",
    "fired_at"  => "2014-06-27 06:09:38",
    "data" => {
      "id"          => "693b7aef55",
      "email"       => subscriber.email,
      "email_type"  => "html",
      "ip_opt"      => "162.243.138.96",
      "web_id"      => "184238353",
      "merges" => {
        "EMAIL" => subscriber.email,
        "FNAME" => subscriber.first_name,
        "LNAME" => subscriber.last_name
      },
      "list_id"=>"117fb7096a"
    }
  }
end

