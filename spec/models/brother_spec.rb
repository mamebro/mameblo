require 'spec_helper'

describe Brother do

  before do
    @brother = Brother.new(name: "kunshika",email: "kunshika@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  subject{ @brother }

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
  it { should respond_to(:followed_brothers) }
  it { should respond_to(:reverse_relationships) }
  it { should respond_to(:followers) }
  it { should respond_to(:following?) }
  it { should respond_to(:follow!) }
  it { should respond_to(:unfollow!) }

  it { should be_valid }
  it { should_not be_admin }


  describe "when name is not present" do
    before { @brother.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @brother.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when name format is invalid" do
    it "should be invalid" do
      brothername = %w[@@@, #, ||, ---]
      brothername.each do |invalid_name|
        @brother.name = invalid_name
        @brother.should_not be_valid
      end      
    end
  end

  describe "when name is already taken" do
    before do
      brother_with_same_name = @brother.dup
      brother_with_same_name.save
    end
    it { should_not be_valid }
  end


  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[brother@foo,com brother_at_foo.org example.brother@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @brother.email = invalid_address
        @brother.should_not be_valid
      end      
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[brother@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @brother.email = valid_address
        @brother.should be_valid
      end      
    end
  end

  describe "when password is not present" do
    before { @brother.password = @brother.password_confirmation = " " }
      it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @brother.password_confirmation = "mismatch" }
      it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @brother.password_confirmation = nil }
      it { should_not be_valid }
  end  

  describe "with a password that's too short" do
    before { @brother.password = @brother.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @brother.save }
    let(:found_brother) { Brother.find_by_name(@brother.name) }
  
  describe "with valid password" do
    it { should == found_brother.authenticate(@brother.password) }
  end

  describe "with invalid password" do
    let(:brother_for_invalid_password) { found_brother.authenticate("invalid") }

    it { should_not == brother_for_invalid_password }
      specify { brother_for_invalid_password.should be_false }
    end
  end

  describe "remember token" do
    before { @brother.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "entry associations" do

    before { @brother.save }
    let!(:older_entry) do 
      FactoryGirl.create(:entry, brother: @brother, created_at: 1.day.ago)
    end
    let!(:newer_entry) do
      FactoryGirl.create(:entry, brother: @brother, created_at: 1.hour.ago)
    end

    it "should have the right entries in the right order" do
      @brother.entries.should == [newer_entry, older_entry]
    end
  end
end
