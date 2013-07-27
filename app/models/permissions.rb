module Permissions
  def self.permission_for(user)
    if user.nil?
      GuestPermission.new
    elsif user.author?
      AuthorPermission.new(user)
    elsif user.admin?
      AdminPermission.new(user)
    end
  end
end
