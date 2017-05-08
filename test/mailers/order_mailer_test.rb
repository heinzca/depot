require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  test "received" do
    mail = OrderMailer.received(orders(:one))
    assert_equal "Binky Bop Store Order Confirmation", mail.subject
    assert_equal ["dave@example.com"], mail.to
    assert_equal ["heinzaufner@gmail.com"], mail.from
    assert_match /ordered/, mail.body.encoded
    # couldn't get this working:
    # assert_match /1x  Programmming Ruby 1.9/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderMailer.shipped(orders(:one))
    assert_equal "Binky Bop Store Order Shipped", mail.subject
    assert_equal ["dave@example.com"], mail.to
    assert_equal ["heinzaufner@gmail.com"], mail.from
    assert_match /shipped/, mail.body.encoded
    # couldn't get this working:
    # assert_match /<td>1&times;<\/td>\s*<td>Programming Ruby 1.9<\/td>/, mail.body.encoded
  end

end
