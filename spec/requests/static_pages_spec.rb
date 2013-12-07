require 'spec_helper'

describe "mame blog(static_pages)" do

  subject { page }

  describe "まめぶろに来たとき" do
    before{ visit root_path }

    describe "サインイン成功すること" do
      let(:brother) { FactoryGirl.create(:brother) }
      before do
        FactoryGirl.create(:entry, brother: brother)
        FactoryGirl.create(:entry, brother: brother)
        sign_in brother
        visit root_path
      end
      it { should have_content('shikakun') }
      it { should have_content('書く') }
      it { should have_content('ブラザーズ') }
      it { should have_content('設定') }
      it { should have_selector('.field #entry-form-title', 'タイトル') }
      it { should have_selector('.button', '投稿') }

    end

    describe "サインイン失敗すること" do
      let(:brother) { FactoryGirl.create(:brother) }

      describe "brother failed login" do 
        before do
          signin_with_failed brother
          visit root_path
        end
        it { should_not have_content('書く') }
        it { should_not have_content('shikakun') }
        it { should_not have_content('ブラザーズ') }
        it { should have_content("あちゃー、もう一回お願いします!!!") }
      end
    end

    describe "新規登録" do
      describe "NGワードは登録できないこと" do
        before do
          visit signup_path
          fill_in 'brother_name', with: 'mameblo'
          fill_in 'brother_email', with: 'mameblo@example.com'
          fill_in 'brother_password', with: 'password'
          fill_in 'brother_password_confirmation', with: 'password'
          click_on 'ブラザーになる!! (無料)'
        end
        it { should have_content("そういう名前は名乗れないよ。") }
      end
    end
  end
end
