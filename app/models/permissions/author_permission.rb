module Permissions
  class AuthorPermission < BasePermission
    def initialize(user)
      allow "devise/sessions", [:new, :create, :destroy]
      allow :content, [:index]
      allow :users, [:edit, :update]
    end
  end
end
