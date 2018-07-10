require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  let(:valid_attributes) {
      brand = Brand.create(name: "nike")
      {name: 'tenis', brand_id: brand.id}
  }


  let(:invalid_attributes) {
    {name: '', brand_id: 1}
  }

  describe "GET #index" do
    it "returns a success response" do
      product = Product.create! valid_attributes
      get :index, params: {product_id: product.id, brand_id: product.brand_id}
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      product = Product.create! valid_attributes
      get :show, params: {id: product.id, brand_id: product.brand_id}
      expect(response).to be_success
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        brand = Brand.create(name: "marca")
        {name: 'camiseta', brand_id: brand.id}
      }

      it "updates the requested product" do
        product = Product.create! valid_attributes
        put :update, params: {id: product.id, brand_id: product.brand_id, product: new_attributes}
        product.reload
        expect(response).to be_success
      end
    end
  end
end