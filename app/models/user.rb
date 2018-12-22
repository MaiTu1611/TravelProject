class User < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :file_mail, dependent: :destroy
  # has_many :travel, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable
         
    # Custom validate
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :password_confirmation, presence: true, length: { minimum:6, maximum: 12 }, if: :is_user?
    validates :password, presence: true, length: { minimum:6, maximum: 12 }, if: :is_user?
	  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
    before_save :default_values
    ROLES = %i[admin user]

  def self.allow_unconfirmed_access_for
    1.minute # Or any time frame you like
  end

	def roles=(roles)
	  	roles = [*roles].map { |r| r.to_sym }
	  	self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
	end

	def roles
		# return 0 array with element in db and ROLES
	  	ROLES.reject do |r|
	    	((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
	  end
	end

	# Check authorization
	def has_role?
	  	self.roles_mask == "admin"
	end

	# Set default when user sign up
	def default_values
		# note self.roles_mask = 2 (user) if self.roles_mask.nil? Set default type user when regist
  	self.roles_mask ||= "user"
	end

	# Check user mode
	def is_user?
		@user_login_role == "user"
	end

	# Save role user when user login success
	def save_role
		@user_login_role = self.roles_mask
	end

  # search
  def self.search(search)
    if search
   	  	User.where(first_name: search)
    else
      	User.all
    end
  end

  # Check confirm when sign up
  # def confirmation_token
  #   if self.confirmation_token
  # end
end
