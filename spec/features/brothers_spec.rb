require 'spec_helper'

feature "Brother pages" do

  subject { page }

  let(:brother) { create(:brother) }

  feature '/ブラザー名でアクセス' do
    scenario 'ブラザーが存在するとき' do
      visit '/' + brother.name
      expect(page.has_content?(brother.name)).to be_truthy
      expect(page.has_title?("まめぶろ | #{brother.name}")).to be_truthy
    end

    scenario 'ブラザーが存在しないとき' do
      visit '/' + 'sister'
      expect(page.has_content?(brother.name)).to be_falsey
      expect(page.has_title?('まめぶろ')).to be_truthy
    end

    scenario '/signin のとき' do
      visit '/' + 'signin'
      expect(page.has_content?('サインイン')).to be_truthy
    end
  end

  feature "サインインした時" do
    before do
      @brother = create(:brother)
      sign_in brother
      visit root_path
      visit brothers_path
    end

    scenario 'ブラザーの一覧が表示されること' do
      is_expected.to have_content('近況')
      is_expected.to have_content brother.name
      is_expected.to have_content @brother.name
    end

    scenario 'ブラザー名をクリックしてブラザー詳細に移動できること' do
      click_link @brother.name
      is_expected.to have_content @brother.name
    end

    scenario '日記を投稿できること' do
      fill_in 'entry-form-title', with: '日記のタイトル'
      fill_in 'entry-form-content', with: 'こんにちは、本文です。'
      click_button '投稿'
      is_expected.to have_content 'ぶろぐ投稿できたね'
    end
  end
end
