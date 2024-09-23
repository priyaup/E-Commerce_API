require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it { should have_many(:products).dependent(:destroy) }
  it { should have_one(:cart).dependent(:destroy) }

  it 'should have many cart_items through cart' do
    cart = create(:cart, user: user)
    product = create(:product, user: user)
    cart_item = create(:cart_item, cart: cart, product: product, quantity: 1)

    expect(user.cart.cart_items).to include(cart_item)
  end

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }

  describe 'roles' do
    it 'is valid with a customer role' do
      user = create(:user, role: 'customer')
      expect(user.role).to eq('customer')
    end

    it 'is valid with a seller role' do
      user = create(:user, role: 'seller')
      expect(user.role).to eq('seller')
    end

    it 'is valid with an admin role' do
      user = create(:user, role: 'admin')
      expect(user.role).to eq('admin')
    end

    it 'defaults to customer role if no role is specified' do
      user = create(:user, role: nil)
      expect(user.role).to eq('customer')
    end
  end
end
