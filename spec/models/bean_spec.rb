require 'spec_helper'

describe Bean do
  let(:brother) { create(:brother) }

  before do
    entry = brother.entries.build(title: "まめぶろ最高",
                                   content: "ここに本文を書いてるよブラザー！")
    @bean = Bean.create(entry: entry, throw_brother_id: brother.id)
  end

  subject{ @bean }

  it { is_expected.to be_valid }
  it { is_expected.to respond_to(:kind) }
  it { is_expected.to respond_to(:entry_id) }
  it { is_expected.to respond_to(:throw_brother_id) }
  it { is_expected.to respond_to(:created_at) }
  it { is_expected.to respond_to(:updated_at) }

  it 'kindのdefaultは0 であること' do
    expect(@bean.kind).to eq(0)
  end
end
