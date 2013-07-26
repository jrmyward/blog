module Permissions
  class GuestPermission < BasePermission
    def initialize
      allow "devise/sessions", [:new, :create, :destroy]
      allow :content, [:index]
      allow :posts, [:index, :show]
    end
  end
end
