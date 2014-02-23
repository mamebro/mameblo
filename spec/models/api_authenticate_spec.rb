require 'spec_helper'

describe ApiAuthenticate do
  let(:brother) { FactoryGirl.create(:brother) }

  it '保存したときにトークンが生成される' do
    brother.api_authenticates.create
    brother.reload
    expect(brother.api_authenticates.first.token).to be_present
  end
end
