require 'spec_helper'

describe PasswordResetsController, type: :controller do
  let(:brother) { create(:brother) }

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      expect(response.response_code).to eq 200
    end
  end

  describe "POST 'create'" do
    context "with valid email" do
      it "sends password reset email" do
        expect {
          post :create, params: { email: brother.email }
        }.to change { ActionMailer::Base.deliveries.size }.by(1)
      end

      it "redirects to root url with notice" do
        post :create, params: { email: brother.email }
        expect(response).to redirect_to(root_url)
        expect(flash[:notice]).to eq("!!! パスワード変更のためのメールを送信しました !!!")
      end
    end

    context "with invalid email" do
      it "does not send email" do
        expect {
          post :create, params: { email: "nonexistent@example.com" }
        }.not_to change { ActionMailer::Base.deliveries.size }
      end

      it "redirects to new password reset url with notice" do
        post :create, params: { email: "nonexistent@example.com" }
        expect(response).to redirect_to(new_password_reset_url)
        expect(flash[:notice]).to eq("!!! メールアドレスが登録されてません !!!")
      end
    end
  end

  describe "GET 'edit'" do
    it "raises error for invalid token" do
      expect {
        get :edit, params: { id: "invalid_token" }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
