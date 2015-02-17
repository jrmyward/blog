module Permissions
  class GuestPermission < BasePermission
    def initialize
      allow "devise/sessions", [:new, :create, :destroy]
      allow :comments, [:index, :new, :create]
        allow_param :comment, [:approved, :body, :commentable_id, :commentable_type, :email, :name,
                               :referrer, :parent_id, :site_url, :user_agent, :user_ip]
      allow :content, [:index]
      allow :posts, [:index, :show]
      allow 'list_subscribers', [:create, :confirm, :new]
        allow_param :list_subscriber, [:email, :first_name, :postal_code]
    end
  end
end
