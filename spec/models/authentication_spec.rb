require 'spec_helper'

describe Authentication do
  let(:brother) { create(:brother) }

  it '保存したときにトークンが生成される' do
    brother.authentications.create
    brother.reload
    expect(brother.authentications.first.token).to be_present
  end
end
