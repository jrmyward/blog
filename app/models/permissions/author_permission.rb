module Permissions
  class AuthorPermission < BasePermission
    def initialize(user)
      allow "devise/sessions", [:new, :create, :destroy]
      allow :content, [:index]
      allow :users, [:edit, :update]
      allow :posts, [:index, :show, :new, :create]
      allow :posts, [:edit, :update] do |post|
        post.author_id == user.id
      end
    end
  end
end
