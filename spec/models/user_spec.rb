require 'spec_helper'

describe User do

  before do
    @user = User.new(name: "shikakun",email: "test@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  subject{ @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:entries) }
  it { should respond_to(:feed) }
  it { should respond_to(:relationships) }
  it { should respond_to(:followed_users) }
  it { should respond_to(:reverse_relationships) }
  it { should respond_to(:followers) }
  it { should respond_to(:following?) }
  it { should respond_to(:follow!) }
  it { should respond_to(:unfollow!) }

  it { should be_valid }
  it { should_not be_admin }


  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when name format is invalid" do
    it "should be invalid" do
      username = %w[@@@, #, ||, ---]
      username.each do |invalid_name|
        @user.name = invalid_name
        @user.should_not be_valid
      end      
    end
  end

  describe "when name is already taken" do
    before do
      user_with_same_name = @user.dup
      user_with_same_name.save
    end
    it { should_not be_valid }
  end


  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end      
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end      
    end
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
      it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
      it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
      it { should_not be_valid }
  end  

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_name(@user.name) }
  
  describe "with valid password" do
    it { should == found_user.authenticate(@user.password) }
  end

  describe "with invalid password" do
    let(:user_for_invalid_password) { found_user.authenticate("invalid") }

    it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      @user.reload.email.should == mixed_case_email.downcase
    end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "entry associations" do

    before { @user.save }
    let!(:older_entry) do 
      FactoryGirl.create(:entry, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_entry) do
      FactoryGirl.create(:entry, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right entries in the right order" do
      @user.entries.should =~ [newer_entry, older_entry]
    end
  end
end
