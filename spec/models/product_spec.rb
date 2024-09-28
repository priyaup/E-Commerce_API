require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:user) { create(:user) }
  let(:product) { build(:product, user: user) }

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }

    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0.01) }

    it "is invalid with a non-numeric price" do
      product.price = "not_a_number"
      expect(product).to_not be_valid
    end

    it "is invalid with a price of 0" do
      product.price = 0
      expect(product).to_not be_valid
    end
  end
end
