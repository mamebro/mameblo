# -*- coding: utf-8 -*-
require 'spec_helper'

describe Entry do

  let(:brother) { FactoryGirl.create(:brother) }
  before do @entry = brother.entries.build(title: "まめぶろ最高",
                                      content: "ここに本文を書いてるよブラザー！") 
    subject { @entry }

  end

  it { should respond_to(:content) }
  it { should respond_to(:brother_id) }
  it { should respond_to(:brother) }

  describe "accessible attributes" do
    it "should not allow access to brother_id" do
      expect do
        Entry.new(brother_id: brother.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when brother_id is not present" do
    before { @entry.brother_id = nil }
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
