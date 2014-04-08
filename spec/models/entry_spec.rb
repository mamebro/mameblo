require 'spec_helper'

describe Entry do

  let(:brother) { FactoryGirl.create(:brother) }
  before do
    @entry = brother.entries.build(title: "まめぶろ最高",
                                   content: "ここに本文を書いてるよブラザー！")
    subject { @entry }
  end

  it { is_expected.to respond_to(:content) }
  it { is_expected.to respond_to(:brother_id) }
  it { is_expected.to respond_to(:brother) }

  describe "when brother_id is not present" do
    before { @entry.brother_id = nil }
    it { is_expected.not_to be_valid }
  end

  describe "with blank content" do
    before { @entry.content = " " }
    it { is_expected.not_to be_valid }
  end
  
  describe "with content that is too long" do
    before { @entry.content = "a" * 100000 }
    it { is_expected.not_to be_valid }
  end

  describe "with blank title" do
    before { @entry.title = " " }
    it { is_expected.not_to be_valid }
  end
  
  describe "with content that is too long" do
    before { @entry.title = "a" * 100000 }
    it { is_expected.not_to be_valid }
  end
end
