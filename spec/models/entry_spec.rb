require 'spec_helper'

describe Entry do

  let(:user) { FactoryGirl.create(:user) }

  subject { @entry }

  before do
    @entry = Entry.create
  end

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  
  describe "many entries appear" do

#    FactoryGirl.create(:entry, user: @user, created_at: 1.year.ago)
#    FactoryGirl.create(:entry, user: @user, created_at: 1.hour.ago)
  end
end
