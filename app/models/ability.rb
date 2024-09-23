class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      if user.admin?
        can :manage, Product  # Admins can manage all products
      elsif user.customer?
        can :read, Product  # Customers can read all products
        can :create, CartItem  # Allow customers to create CartItems
        can :manage, CartItem, cart: { user_id: user.id }  # Allow customers to manage their own CartItems
      elsif user.seller?
        can :create, Product  # Allow sellers to create products
        can :manage, Product, user_id: user.id  # Allow sellers to manage their own products
        can :read, Product, user_id: user.id  # Allow sellers to view their own products only
      end
    else
      can :read, Product  # Guests can read products
    end
  end
end
