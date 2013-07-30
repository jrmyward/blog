module Permissions
  class AuthorPermission < BasePermission
    def initialize(user)
      allow "devise/sessions", [:new, :create, :destroy]
      allow :content, [:index]
      allow "admins/users", [:edit, :update]
      allow_param :user, :first_name
      allow_param :user, :last_name
      allow_param :user, :email
      allow_param :user, :gplus
      allow_param :user, :twitter_handle
      allow_param :user, :password
      allow_param :user, :password_confirmation
      allow_param :user, :current_password
      allow :posts, [:index, :show, :new, :create]
      allow :posts, [:edit, :update] do |post|
        post.author_id == user.id
      end
    end
  end
end
