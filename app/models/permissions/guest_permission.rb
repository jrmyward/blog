module Permissions
  class GuestPermission < BasePermission
    def initialize
      allow :sessions, [:new, :create, :destroy]
    end
  end
end
