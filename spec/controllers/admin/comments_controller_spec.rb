require 'rails_helper'

RSpec.describe Admin::CommentsController, type: :controller do
  let(:valid_attributes) { attributes_for(:comment, commentable_id: 1, commentable_type: "Post") }
  let(:valid_user) { attributes_for(:user) }
  let(:admin) { User.create(valid_user.merge({role: "admin"})) }

  before(:each) do
    allow_any_instance_of(Comment).to receive(:spam?).and_return(false)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in admin
  end

  describe "GET index" do
    it "assigns all comments as @comments" do
      comment = Comment.create! valid_attributes
      get :index, {}
      expect(assigns(:comments)).to eq([comment])
    end
  end

  describe "GET edit" do
    it "assigns the requested comment as @comment" do
      comment = Comment.create! valid_attributes
      get :edit, {:id => comment.id}
      expect(assigns(:comment)).to eq(comment)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested comment" do
        comment = Comment.create! valid_attributes
        expect_any_instance_of(Comment).to receive(:update).with({ "body" => "Some text." })
        put :update, {:id => comment.id, :comment => { "body" => "Some text." }}
      end

      it "assigns the requested comment as @comment" do
        comment = Comment.create! valid_attributes
        put :update, {:id => comment.id, :comment => valid_attributes}
        expect(assigns(:comment)).to eq(comment)
      end

      it "redirects to the comment" do
        comment = Comment.create! valid_attributes
        put :update, {:id => comment.id, :comment => valid_attributes}
        expect(response).to redirect_to(admin_comments_path)
      end
    end

    describe "with invalid params" do
      it "assigns the comment as @comment" do
        comment = Comment.create! valid_attributes
        expect_any_instance_of(Comment).to receive(:save).and_return(false)
        put :update, {:id => comment.id, :comment => {  }}
        expect(assigns(:comment)).to eq(comment)
      end

      it "re-renders the 'edit' template" do
        comment = Comment.create! valid_attributes
        expect_any_instance_of(Comment).to receive(:save).and_return(false)
        put :update, {:id => comment.id, :comment => {  }}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "PUT approve" do
    it "marks approved to true" do
      expect_any_instance_of(Comment).to receive(:ham!).and_return(true)
      comment = Comment.create! valid_attributes.merge(approved: false)
      put :approve, { id: comment.id }
      expect(comment.reload.approved).to be true
    end
  end

  describe "PUT reject" do
    it "marks sets approved to false" do
      expect_any_instance_of(Comment).to receive(:spam!).and_return(true)
      comment = Comment.create! valid_attributes.merge(approved: true)
      put :reject, { id: comment.id }
      expect(comment.reload.approved).to be false
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested comment" do
      comment = Comment.create! valid_attributes
      expect {
        delete :destroy, {:id => comment.id}
      }.to change(Comment, :count).by(-1)
    end

    it "redirects to the admin dashboard" do
      comment = Comment.create! valid_attributes
      delete :destroy, {:id => comment.id}
      expect(response).to redirect_to(admin_comments_path)
    end
  end

  describe "DELETE destroy_batch" do
    before(:each) do
      comment1 = Comment.create! valid_attributes
      comment2 = Comment.create! valid_attributes
      comment3 = Comment.create! valid_attributes
      @destroy_comment_ids = [comment1.id, comment3.id]
    end

    it "destroys the checked comments" do
      expect {
        delete :destroy_batch, { comment_ids: @destroy_comment_ids }
      }.to change(Comment, :count).by(-2)
    end

    it "redirects to the admin dashboard" do
      delete :destroy_batch, { comment_ids: @destroy_comment_ids }
      expect(response).to redirect_to(admin_comments_path)
    end
  end

end
