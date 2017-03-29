require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  # defines the products fixture to be used in this test to load data in the test db
  fixtures :products

  test "product attributes must not be empty" do
    # tests for valid product and presence of fields
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
    # tests negative and 0 are invalid, plus positive is valid
    product = Product.new(title: "My Book Title", description: "yyy", image_url: "zzz.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 1
    assert product.valid?
  end


  # method used in the image_url test following
  def new_product(image_url)
    Product.new(title: "My Book Title", description: "yyy", price: 1, image_url: image_url)
  end

  test "image url" do
    # tests for a valid image url - checking for a valid extension
    # uses a block to test each value in the arrays
    ok = %w{fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{fred.doc fred.gif/more fred.gif.more }

    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end

    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end

  end

  test "product is not valid without a unique title" do
    # this test uses the fixture, which has a record for title ruby
    # it then attempts to add another record with the same value and tests that it can't be saved and that the correct error is raised
    product = Product.new(title: products(:ruby).title, description: "yyy", price: 1, image_url: "fred.gif")
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end

  test "product is not valid without a unique title - i18n" do
    # this test is the same as the previous, except that it avoids hard-coding the error string, instead checking for the response against the built-in error message table
    product = Product.new(title: products(:ruby).title, description: "yyy", price: 1, image_url: "fred.gif")
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
  end
end
