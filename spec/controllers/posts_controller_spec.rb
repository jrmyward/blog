require 'rails_helper'

describe PostsController, type: :controller do
  let(:user) { create(:user, role: "admin") }
  let(:valid_attributes) { attributes_for(:post, author_id: user.id) }

  describe "GET index" do
    it "assigns all posts as @posts" do
      post = Post.create! valid_attributes
      get :index, {}
      expect(assigns(:posts)).to eq([post])
    end
  end

  describe "GET show" do
    it "assigns the requested post as @post" do
      post = Post.create! valid_attributes
      get :show, {:id => post.to_param}
      expect(assigns(:post)).to eq(post)
    end
  end

end
