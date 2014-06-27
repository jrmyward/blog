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

end
