require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe Admin::CommentsController do
  let(:valid_attributes) { FactoryGirl.attributes_for(:comment, commentable_id: 1, commentable_type: "Post") }
  let(:valid_user) { FactoryGirl.attributes_for(:user) }
  let(:admin) { User.create(valid_user.merge({role: "admin"})) }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in admin
  end

  describe "GET index" do
    it "assigns all comments as @comments" do
      comment = Comment.create! valid_attributes
      get :index, {}
      assigns(:comments).should eq([comment])
    end
  end

  describe "GET show" do
    it "assigns the requested comment as @comment" do
      comment = Comment.create! valid_attributes
      get :show, {:id => comment.id}
      assigns(:comment).should eq(comment)
    end
  end

  describe "GET edit" do
    it "assigns the requested comment as @comment" do
      comment = Comment.create! valid_attributes
      get :edit, {:id => comment.id}
      assigns(:comment).should eq(comment)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested comment" do
        comment = Comment.create! valid_attributes
        # Assuming there are no other comments in the database, this
        # specifies that the Comment created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Comment.any_instance.should_receive(:update).with({ "these" => "params" })
        put :update, {:id => comment.id, :comment => { "these" => "params" }}
      end

      it "assigns the requested comment as @comment" do
        comment = Comment.create! valid_attributes
        put :update, {:id => comment.id, :comment => valid_attributes}
        assigns(:comment).should eq(comment)
      end

      it "redirects to the comment" do
        comment = Comment.create! valid_attributes
        put :update, {:id => comment.id, :comment => valid_attributes}
        response.should redirect_to(user_root_path)
      end
    end

    describe "with invalid params" do
      it "assigns the comment as @comment" do
        comment = Comment.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Comment.any_instance.stub(:save).and_return(false)
        put :update, {:id => comment.id, :comment => {  }}
        assigns(:comment).should eq(comment)
      end

      it "re-renders the 'edit' template" do
        comment = Comment.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Comment.any_instance.stub(:save).and_return(false)
        put :update, {:id => comment.id, :comment => {  }}
        response.should render_template("edit")
      end
    end
  end

  describe "PUT approve" do
    it "marks approved to true" do
      comment = Comment.create! valid_attributes.merge(approved: false)
      put :approve, { id: comment.id }
      comment.reload.approved.should be_true
    end
  end

  describe "PUT reject" do
    it "marks sets approved to false" do
      comment = Comment.create! valid_attributes.merge(approved: true)
      put :reject, { id: comment.id }
      comment.reload.approved.should be_false
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
      response.should redirect_to(user_root_path)
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
      response.should redirect_to(user_root_path)
    end
  end

end
