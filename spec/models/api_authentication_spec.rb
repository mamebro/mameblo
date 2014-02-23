require 'spec_helper'

describe ApiAuthentication do
  let(:brother) { FactoryGirl.create(:brother) }

  it '保存したときにトークンが生成される' do
    brother.api_authentications.create
    brother.reload
    expect(brother.api_authentications.first.token).to be_present
  end
end
