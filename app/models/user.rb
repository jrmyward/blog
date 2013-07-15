class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = %w[admin author member]

  validates_presence_of :first_name, :last_name
  validates_inclusion_of :role, :in => ROLES,
                          :message => "The role <strong>{{value}}</strong> is not valid.",
                          :if => "role.present?"

  def admin?
    role === "admin"
  end
end
