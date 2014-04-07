require 'spec_helper'

describe Brother do

  before do
    @brother = Brother.new(name: "kunshika",email: "kunshika@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  subject{ @brother }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:password_digest) }
  it { is_expected.to respond_to(:password) }
  it { is_expected.to respond_to(:password_confirmation) }
  it { is_expected.to respond_to(:authenticate) }
  it { is_expected.to respond_to(:remember_token) }
  it { is_expected.to respond_to(:admin) }
  it { is_expected.to respond_to(:authenticate) }
  it { is_expected.to respond_to(:entries) }
  it { is_expected.to respond_to(:feed) }
  it { is_expected.to respond_to(:relationships) }
  it { is_expected.to respond_to(:followed_brothers) }
  it { is_expected.to respond_to(:reverse_relationships) }
  it { is_expected.to respond_to(:followers) }
  it { is_expected.to respond_to(:following?) }
  it { is_expected.to respond_to(:follow!) }
  it { is_expected.to respond_to(:unfollow!) }

  it { is_expected.to be_valid }
  it { is_expected.not_to be_admin }


  describe "when name is not present" do
    before { @brother.name = " " }
    it { is_expected.not_to be_valid }
  end

  describe "when name contains white space" do
    before { @brother.name = "kun shi ka" }
    it { is_expected.not_to be_valid }
  end

  describe "when name is too long" do
    before { @brother.name = "a" * 51 }
    it { is_expected.not_to be_valid }
  end

  describe "when name format is invalid" do
    it "should be invalid" do
      brothername = %w[@@@, #, ||, ---, www.nakaotakashi.com]
      brothername.each do |invalid_name|
        @brother.name = invalid_name
        expect(@brother).not_to be_valid
      end
    end
  end

  describe "when name is already taken" do
    before do
      brother_with_same_name = @brother.dup
      brother_with_same_name.save
    end
    it { is_expected.not_to be_valid }
  end


  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[brother@foo,com brother_at_foo.org example.brother@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @brother.email = invalid_address
        expect(@brother).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[brother@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @brother.email = valid_address
        expect(@brother).to be_valid
      end
    end
  end

  describe "when password is not present" do
    before { @brother.password = @brother.password_confirmation = " " }
      it { is_expected.not_to be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @brother.password_confirmation = "mismatch" }
      it { is_expected.not_to be_valid }
  end

  describe "when password confirmation is nil" do
    before { @brother.password_confirmation = nil }
      it { is_expected.not_to be_valid }
  end

  describe "with a password that's too short" do
    before { @brother.password = @brother.password_confirmation = "a" * 5 }
    it { is_expected.to be_invalid }
  end

  describe "return value of authenticate method" do
    before { @brother.save }
    let(:found_brother) { Brother.find_by_name(@brother.name) }

  describe "with valid password" do
    it { is_expected.to eq(found_brother.authenticate(@brother.password)) }
  end

  describe "with invalid password" do
    let(:brother_for_invalid_password) { found_brother.authenticate("invalid") }

    it { is_expected.not_to eq(brother_for_invalid_password) }
      specify { expect(brother_for_invalid_password).to be_falsey }
    end
  end

  describe "remember token" do
    before { @brother.save }

    describe '#remember_token' do
      subject { super().remember_token }
      it { is_expected.not_to be_blank }
    end
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
      expect(@brother.entries).to eq([newer_entry, older_entry])
    end
  end

  describe "find_by_name_or_id" do
    before { @brother.save }

    it "find by name should return brother" do
      expect(Brother.find_by_name_or_id(@brother.name)).to eq(@brother)
    end

    it "find by id should return brother" do
      expect(Brother.find_by_name_or_id(@brother.id)).to eq(@brother)
    end
  end
end
