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

  describe "resource name is defined" do
    before { @brother.name = "discover" }
    it { is_expected.not_to be_valid }
  end

  describe "resource name is not defined" do
    before { @brother.name = "discove" }
    it { is_expected.to be_valid }
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
      create(:entry, brother: @brother, created_at: 1.day.ago)
    end
    let!(:newer_entry) do
      create(:entry, brother: @brother, created_at: 1.hour.ago)
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

  describe "#following?" do
    let(:other_brother) { create(:brother) }

    before { @brother.save }

    it "returns truthy when following" do
      @brother.follow!(other_brother)
      expect(@brother.following?(other_brother)).to be_truthy
    end

    it "returns falsy when not following" do
      expect(@brother.following?(other_brother)).to be_falsy
    end
  end

  describe "#follow!" do
    let(:other_brother) { create(:brother) }

    before { @brother.save }

    it "creates a relationship" do
      expect {
        @brother.follow!(other_brother)
      }.to change(Relationship, :count).by(1)
    end

    it "adds brother to followed_brothers" do
      @brother.follow!(other_brother)
      expect(@brother.followed_brothers).to include(other_brother)
    end
  end

  describe "#unfollow!" do
    let(:other_brother) { create(:brother) }

    before do
      @brother.save
      @brother.follow!(other_brother)
    end

    it "destroys the relationship" do
      expect {
        @brother.unfollow!(other_brother)
      }.to change(Relationship, :count).by(-1)
    end

    it "removes brother from followed_brothers" do
      @brother.unfollow!(other_brother)
      expect(@brother.followed_brothers).not_to include(other_brother)
    end
  end

  describe "#feed" do
    let(:followed_brother) { create(:brother) }
    let(:unfollowed_brother) { create(:brother) }

    before do
      @brother.save
      @brother.follow!(followed_brother)
    end

    let!(:own_entry) { create(:entry, brother: @brother) }
    let!(:followed_entry) { create(:entry, brother: followed_brother) }
    let!(:unfollowed_entry) { create(:entry, brother: unfollowed_brother) }

    it "includes own entries" do
      expect(@brother.feed).to include(own_entry)
    end

    it "includes followed brother entries" do
      expect(@brother.feed).to include(followed_entry)
    end

    it "excludes unfollowed brother entries" do
      expect(@brother.feed).not_to include(unfollowed_entry)
    end
  end

  describe "#to_param" do
    it "returns the brother name" do
      expect(@brother.to_param).to eq(@brother.name)
    end
  end

  describe "#send_password_reset" do
    before { @brother.save }

    it "generates a password reset token" do
      @brother.send_password_reset
      expect(@brother.password_reset_token).to be_present
    end

    it "sets the password_reset_sent_at" do
      @brother.send_password_reset
      expect(@brother.password_reset_sent_at).to be_present
    end

    it "sends an email" do
      expect {
        @brother.send_password_reset
      }.to change { ActionMailer::Base.deliveries.size }.by(1)
    end
  end

  describe "dependent destroy" do
    before { @brother.save }

    it "destroys associated entries" do
      create(:entry, brother: @brother)
      expect { @brother.destroy }.to change(Entry, :count).by(-1)
    end

    it "destroys associated relationships" do
      other = create(:brother)
      @brother.follow!(other)
      expect { @brother.destroy }.to change(Relationship, :count).by(-1)
    end

    it "destroys associated authentications" do
      @brother.authentications.create
      expect { @brother.destroy }.to change(Authentication, :count).by(-1)
    end
  end

  describe "followers" do
    let(:other_brother) { create(:brother) }

    before do
      @brother.save
      other_brother.follow!(@brother)
    end

    it "includes the follower" do
      expect(@brother.followers).to include(other_brother)
    end
  end
end
