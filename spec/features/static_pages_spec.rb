require 'spec_helper'

feature "mame blog(static_pages)" do

  subject { page }

  feature "まめぶろに来たとき" do
    before{ visit root_path }

    feature "サインイン成功すること" do
      let(:brother) { FactoryGirl.create(:brother) }
      before do
        FactoryGirl.create(:entry, brother: brother)
        FactoryGirl.create(:entry, brother: brother)
        sign_in brother
      end

      scenario { is_expected.to have_content('わたし') }
      scenario { is_expected.to have_content('兄弟') }
      scenario { is_expected.to have_content('みんな') }
      scenario { is_expected.to have_content('設定') }
      scenario { is_expected.to have_selector('.field #entry-form-title', 'タイトル') }
      scenario { is_expected.to have_selector('.button', '投稿') }

    end

    feature "サインイン失敗すること" do
      let(:brother) { FactoryGirl.create(:brother) }

      feature "brother failed login" do
        before do
          signin_with_failed(brother)
        end

        scenario { is_expected.not_to have_content('兄弟') }
        scenario { is_expected.not_to have_content('わたし') }
        scenario { is_expected.not_to have_content('みんな') }
        scenario { is_expected.to have_content("あちゃー、もう一回お願いします!!!") }
      end
    end

    feature "新規登録" do
      feature "NGワードは登録できないこと" do
        before do
          visit signup_path
          fill_in 'brother_name', with: 'mameblo'
          fill_in 'brother_email', with: 'mameblo@example.com'
          fill_in 'brother_password', with: 'password'
          fill_in 'brother_password_confirmation', with: 'password'
          click_on 'ブラザーになる!! (無料)'
        end
        scenario { is_expected.to have_content("そういう名前は名乗れないよ。") }
      end
    end
  end
end
