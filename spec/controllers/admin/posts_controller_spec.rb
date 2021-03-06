require 'rails_helper'

describe Admin::PostsController, type: :controller do
  let(:admin) { create(:user, role: "admin") }
  let(:valid_attributes) { attributes_for(:post, author_id: admin.id) }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in admin
  end

  describe "GET index" do
    it "assigns all admin_posts as @posts" do
      post = Post.create! valid_attributes
      get :index, {}
      expect(assigns(:posts)).to eq([post])
    end
  end

  describe "GET new" do
    it "assigns a new post as @post" do
      get :new, {}
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe "GET edit" do
    it "assigns the requested post as @post" do
      post = Post.create! valid_attributes
      get :edit, {:id => post.to_param}
      expect(assigns(:post)).to eq(post)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Admin::Post" do
        expect {
          post :create, {:post => valid_attributes}
        }.to change(Post, :count).by(1)
      end

      it "assigns a newly created post as @post" do
        post :create, {:post => valid_attributes}
        expect(assigns(:post)).to be_a(Post)
        expect(assigns(:post)).to be_persisted
      end

      it "redirects to the created post" do
        post :create, {:post => valid_attributes}
        expect(response).to redirect_to(admin_posts_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved post as @post" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Post).to receive(:save).and_return(false)
        post :create, {:post => {  }}
        expect(assigns(:post)).to be_a_new(Post)
      end

      it "re-renders the 'new' template" do
        post :create, {:post => attributes_for(:post, author_id: admin.id, title: '') }
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested post" do
        post = Post.create! valid_attributes
        # Assuming there are no other posts in the database, this
        # specifies that the Post created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Post).to receive(:update).with({ "these" => "params" })
        put :update, {:id => post.to_param, :post => { "these" => "params" }}
      end

      it "assigns the requested post as @post" do
        post = Post.create! valid_attributes
        put :update, {:id => post.to_param, :post => valid_attributes}
        expect(assigns(:post)).to eq(post)
      end

      it "redirects to the post" do
        post = Post.create! valid_attributes
        put :update, {:id => post.to_param, :post => valid_attributes}
        expect(response).to redirect_to(admin_posts_path)
      end
    end

    describe "with invalid params" do
      it "assigns the post as @post" do
        post = Post.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Post).to receive(:save).and_return(false)
        put :update, {:id => post.to_param, :post => {  }}
        expect(assigns(:post)).to eq(post)
      end

      it "re-renders the 'edit' template" do
        post = Post.create! valid_attributes
        put :update, {:id => post.to_param, post: {title: ''} }
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested post" do
      post = Post.create! valid_attributes
      expect {
        delete :destroy, {:id => post.id}
      }.to change(Post, :count).by(-1)
    end

    it "redirects to the posts list" do
      post = Post.create! valid_attributes
      delete :destroy, {:id => post.id}
      expect(response).to redirect_to(admin_posts_url)
    end
  end

end
