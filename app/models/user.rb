class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  before_create :set_default_role
  after_create :create_cart

  has_many :products, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_one :cart, dependent: :destroy

  validates :email,presence:true , uniqueness:true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  def self.ransackable_associations(auth_object = nil)
    ["cart", "cart_items", "products"]
  end
  
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "encrypted_password", "id", "jti", "remember_created_at", "reset_password_sent_at", "reset_password_token", "role", "updated_at"]
  end
  

  ROLES = %w[customer seller admin].freeze

  def jwt_payload
   super
  end

  ROLES.each do |role_name|
    define_method "#{role_name}?" do
      role == role_name
    end
  end

  private 

  def set_default_role
    self.role ||= 'customer'
  end

 def create_cart
    Cart.create(user: self)
  end
  
end
