require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "is valid with valid attributes" do
    user = User.new(
      name: "Jane Doe",
      dob: Date.new(2000, 1, 1),
      email: "jane@example.com",
      phone_number: "555-0101",
      address: "1 Test Street"
    )

    assert user.valid?
  end

  test "requires presence of all fields" do
    user = User.new

    assert_not user.valid?
    assert_includes user.errors[:name], "can't be blank"
    assert_includes user.errors[:dob], "can't be blank"
    assert_includes user.errors[:email], "can't be blank"
    assert_includes user.errors[:phone_number], "can't be blank"
  end

  test "requires a valid email format" do
    user = User.new(
      name: "Jane Doe",
      dob: Date.new(2000, 1, 1),
      email: "invalid-email",
      phone_number: "555-0101",
      address: "1 Test Street"
    )

    assert_not user.valid?
    assert_includes user.errors[:email], "is invalid"
  end

  test "requires unique email" do
    user = User.new(
      name: "Another User",
      dob: Date.new(2000, 1, 1),
      email: users(:one).email,
      phone_number: "555-0102",
      address: "2 Test Street"
    )

    assert_not user.valid?
    assert_includes user.errors[:email], "has already been taken"
  end
end