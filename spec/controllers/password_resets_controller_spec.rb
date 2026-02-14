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
    before { brother.send_password_reset }

    it "returns http success" do
      get :edit, params: { id: brother.password_reset_token }
      expect(response.response_code).to eq 200
    end

    it "assigns the brother" do
      get :edit, params: { id: brother.password_reset_token }
      expect(assigns(:brother)).to eq(brother)
    end

    it "raises error for invalid token" do
      expect {
        get :edit, params: { id: "invalid_token" }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "PATCH 'update'" do
    before { brother.send_password_reset }

    context "with valid token and within time limit" do
      it "updates the password" do
        patch :update, params: { id: brother.password_reset_token,
                                 brother: { name: brother.name, email: brother.email,
                                            password: 'newpassword', password_confirmation: 'newpassword' } }
        expect(response).to redirect_to(root_url)
        expect(flash[:notice]).to eq("!!! パスワード再設定できました !!!")
      end
    end

    context "with expired token" do
      before do
        brother.update_column(:password_reset_sent_at, 3.hours.ago)
      end

      it "redirects to new password reset path" do
        patch :update, params: { id: brother.password_reset_token,
                                 brother: { name: brother.name, email: brother.email,
                                            password: 'newpassword', password_confirmation: 'newpassword' } }
        expect(response).to redirect_to(new_password_reset_path)
        expect(flash[:alert]).to eq("!!! 有効期限切れです !!!")
      end
    end

    context "with invalid params" do
      it "renders edit template" do
        patch :update, params: { id: brother.password_reset_token,
                                 brother: { name: brother.name, email: brother.email,
                                            password: 'a', password_confirmation: 'b' } }
        expect(response).to render_template(:edit)
      end
    end
  end
end
