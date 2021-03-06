require 'rails_helper'

RSpec.describe Product, type: :model do

  before(:each) do
    @category = Category.new
  end

  describe 'Validations' do
    # validation tests/examples here
    it "product should belong to a category with name, price and quantity" do
      @product = @category.products.new(name: 'Cool looking useless product', price: 320, quantity: 35)
      expect(@product).to be_valid
      expect(@product.save).to be true
    end
    it "is not valid without a name" do
      @product = @category.products.new(price: 320, quantity: 35)
      expect(@product).to_not be_valid
      expect(@product.save).to be false
    end
    it "is not valid without a price" do
      @product = @category.products.new(name: 'Cool looking useless product', quantity: 35)
      expect(@product).to_not be_valid
      expect(@product.save).to be false
    end
    it "is not valid without a quantity" do
      @product = @category.products.new(name: 'Cool looking useless product', price: 320)
      expect(@product).to_not be_valid
      expect(@product.save).to be false
    end
    it "is not valid without a category" do
      @product = Product.new(name: 'Cool looking useless product', price: 320, quantity: 35)
      expect(@product).to_not be_valid
      expect(@product.save).to be false
    end



  end
end
