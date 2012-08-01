# -*- coding: utf-8 -*-
require 'spec_helper'

describe Entry do

  let(:user) { FactoryGirl.create(:user) }
  before do @entry = user.entries.build(title: "まめぶろ最高",
                                      content: "ここに本文を書いてるよブラザー！") 
    subject { @entry }

  end

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Entry.new(user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @entry.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @entry.content = " " }
    it { should_not be_valid }
  end
  
  describe "with content that is too long" do
    before { @entry.content = "a" * 100000 }
    it { should_not be_valid }
  end

  describe "with blank title" do
    before { @entry.title = " " }
    it { should_not be_valid }
  end
  
  describe "with content that is too long" do
    before { @entry.title = "a" * 100000 }
    it { should_not be_valid }
  end
end
