require "rails_helper"

RSpec.describe User, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
  end

  it "is valid with valid attributes" do
    expect(@user).to be_valid
  end

  it "is not valid without a name" do
    @user.name = nil
    expect(@user).to_not be_valid
  end

  it "is not valid without an email" do
    @user.email = nil
    expect(@user).to_not be_valid
  end

  it "is not valid with an invalid email format" do
    @user.email = "invalid_email"
    expect(@user).to_not be_valid
  end

  it "is not valid without a password" do
    @user.password = nil
    expect(@user).to_not be_valid
  end

  it "is not valid with a short password" do
    @user.password = "short"
    expect(@user).to_not be_valid
  end

  it "is associated with reviews" do
    expect(@user).to have_many(:reviews).dependent(:destroy)
  end

  it "is associated with transactions" do
    expect(@user).to have_many(:transactions).dependent(:destroy)
  end

  it "is associated with user_like_books" do
    expect(@user).to have_many(:user_like_books).dependent(:destroy)
  end

  it "is associated with books through user_like_books" do
    expect(@user).to have_many(:books).through(:user_like_books)
  end

  it "is associated with follows" do
    expect(@user).to have_many(:follows).dependent(:destroy)
  end

  it "is case-insensitively unique for email" do
    new_user = FactoryBot.build(:user, email: @user.email.upcase)
    expect(new_user).to_not be_valid
  end

  it "is associated with a default role of 'normal_user'" do
    expect(@user).to have_attributes(role: "normal_user")
  end

  it "is associated with a default gender of 'male'" do
    expect(@user).to have_attributes(gender: "male")
  end

  it "is activated by default" do
    expect(@user).to be_activated
  end

  it "is not activated after creation" do
    new_user = FactoryBot.create(:user, activated: false)
    expect(new_user).to_not be_activated
  end

  it "can be activated" do
    @user.activate
    expect(@user).to be_activated
  end

  it "can be inactivated" do
    @user.inactivate
    expect(@user).to_not be_activated
  end

  it "can be authenticated with a valid token" do
    token = @user.activation_token
    expect(@user.authenticated?(:activation, token)).to eq(true)
  end

  it "cannot be authenticated with an invalid token" do
    token = "invalid_token"
    expect(@user.authenticated?(:activation, token)).to eq(false)
  end

end
