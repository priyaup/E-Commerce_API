require 'rails_helper'
RSpec.describe CartItem, type: :model do
  let(:cart) { create(:cart) }
  let(:product) { create(:product) }
  let(:cart_item) { create(:cart_item, cart: cart, product: product, quantity: 2) }

  it { should belong_to(:cart) }
  it { should belong_to(:product) }

  it { should validate_presence_of(:product_id) }
  it { should validate_numericality_of(:quantity).only_integer.is_greater_than(0) }

  it 'is valid with valid attributes' do
    expect(cart_item).to be_valid
  end

  it 'is invalid without a product' do
    cart_item.product = nil
    expect(cart_item).to_not be_valid
  end
end

