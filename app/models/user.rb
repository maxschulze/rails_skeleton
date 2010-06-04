class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :user_name
  
  has_role
  
  cattr_reader :current
  
  # def self.find_for_authentication(conditions = {})
  #     conditions = [
  #       "user_name LIKE ? or email LIKE ? or (first_name LIKE ? and last_name LIKE ?)", 
  #       conditions[:email], 
  #       conditions[:email], 
  #       conditions[:email], 
  #       conditions[:email]
  #     ]
  #     # raise StandardError, conditions.inspect
  #     super
  #   end
end
