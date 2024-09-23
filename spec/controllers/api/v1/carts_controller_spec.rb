require 'rails_helper'

RSpec.describe Api::V1::CartsController, type: :controller do
  let(:user) { create(:user) }
  let!(:cart) { create(:cart, user: user) }

  before do
    sign_in user
  end

  describe "GET #show" do
    it "returns the cart with items" do
      get :show
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(cart.cart_items.size)
    end
  end
end
