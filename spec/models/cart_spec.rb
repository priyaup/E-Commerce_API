require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }

  it { should belong_to(:user) }
  it { should have_many(:cart_items).dependent(:destroy) }

  it 'is valid with a user' do
    expect(cart).to be_valid
  end

  it 'has many cart items' do
    product = create(:product, user: user)
    cart_item = create(:cart_item, cart: cart, product: product, quantity: 1)
    
    expect(cart.cart_items).to include(cart_item)
  end

  it 'destroys associated cart_items when destroyed' do
    product = create(:product, user: user)
    cart_item = create(:cart_item, cart: cart, product: product, quantity: 1)
    
    expect { cart.destroy }.to change(CartItem, :count).by(-1)
  end
end


