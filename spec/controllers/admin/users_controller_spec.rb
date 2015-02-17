require 'rails_helper'

describe Admin::UsersController, type: :controller do
  let(:valid_user) { attributes_for(:user) }
  let(:valid_attributes) { attributes_for(:user, first_name: "Tony", last_name: "Stark", current_password: valid_user[:password]) }
  let(:admin) { User.create(valid_user.merge({role: "admin"})) }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in admin
  end

  # describe "GET index" do
  #   it "assigns all users as @users" do
  #     get :index, {}
  #     expect(assigns(:users)).to eq([admin])
  #   end
  # end

  # describe "GET show" do
  #   it "assigns the requested user as @user" do
  #     get :show, {id: admin.id}
  #     expect(assigns(:user)).to eq(admin)
  #   end
  # end

  # describe "GET new" do
  #   it "assigns a new user as @user" do
  #     get :new, {}Admin
  #     expect(assigns(:user)).to be_a_new(User)
  #   end
  # end

  describe "GET edit" do
    it "assigns the requested user as @user" do
      get :edit, {id: admin.id}
      expect(assigns(:user)).to eq(admin)
    end
  end

  # describe "POST create" do
  #   describe "with valid params" do
  #     it "creates a new Admin" do
  #       expect {
  #         post :create, {admin: valid_attributes}
  #       }.to change(Admin, :count).by(1)
  #     end

  #     it "assigns a newly created user as @user" do
  #       post :create, {admin: valid_attributes}
  #       expect(assigns(:user)).to be_a(Admin)
  #       expect(assigns(:user)).to be_persisted
  #     end

  #     it "redirects to the created user" do
  #       post :create, {admin: valid_attributes}
  #       expect(response).to redirect_to(admin_users_path)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns a newly created but unsaved user as @user" do
  #       post :create, { admin: { email: "" } }
  #       expect(assigns(:user)).to be_a_new(Admin)
  #     end

  #     it "re-renders the 'new' template" do
  #       post :create, { admin: { email: "" } }
  #       expect(response).to render_template("new")
  #     end
  #   end
  # end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested user" do
        put :update, {id: admin.id, user: valid_attributes}
        u = User.find_by_id(admin.id)
        expect(u.first_name).to eq valid_attributes[:first_name]
      end

      it "assigns the requested user as @user" do
        put :update, {id: admin.id, user: valid_attributes}
        expect(assigns(:user)).to eq(admin)
      end

      it "redirects to the user" do
        put :update, {id: admin.id, user: valid_attributes}
        expect(response).to redirect_to(edit_admin_user_path(admin))
      end
    end

    describe "with invalid params" do
      it "assigns the user as @user" do
        put :update, {id: admin.id,  user: { email: "" } }
        expect(assigns(:user)).to eq(admin)
      end

      it "re-renders the 'edit' template" do
        put :update, {id: admin.id,  user: { email: "" } }
        expect(response).to render_template("edit")
      end
    end
  end


  # describe "DELETE destroy" do
  #   it "destroys the requested user" do
  #     user = User.create! valid_attributes
  #     expect {
  #       delete :destroy, {id: user.id}
  #     }.to change(Admin, :count).by(-1)
  #   end

  #   it "redirects to the users list" do
  #     user = User.create! valid_attributes
  #     delete :destroy, {id: user.id}
  #     expect(response).to redirect_to(admin_users_path)
  #   end
  # end

end
