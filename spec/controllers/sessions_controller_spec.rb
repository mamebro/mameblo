require 'spec_helper'

describe SessionsController, type: :controller do
  let(:brother) { create(:brother) }

  before do
    allow(CaptchaService).to receive(:validate).and_return(true)
  end

  describe "POST 'create'" do
    context "with valid credentials" do
      it "signs in the brother" do
        post :create, params: { session: { name: brother.name, password: brother.password } }
        expect(cookies[:remember_token]).to eq(brother.remember_token)
      end

      it "redirects to root path" do
        post :create, params: { session: { name: brother.name, password: brother.password } }
        expect(response).to redirect_to(root_path)
      end

      it "sets success flash message" do
        post :create, params: { session: { name: brother.name, password: brother.password } }
        expect(flash[:success]).to eq("!!!!!!!! ブラザーよ !!!!!!!!")
      end
    end

    context "with invalid credentials" do
      it "does not sign in" do
        post :create, params: { session: { name: brother.name, password: "wrong" } }
        expect(cookies[:remember_token]).to be_nil
      end

      it "renders new template" do
        post :create, params: { session: { name: brother.name, password: "wrong" } }
        expect(response).to render_template('new')
      end

      it "sets error flash message" do
        post :create, params: { session: { name: brother.name, password: "wrong" } }
        expect(flash[:error]).to eq("あちゃー、もう一回お願いします!!!")
      end
    end

    context "with invalid captcha" do
      before do
        allow(CaptchaService).to receive(:validate).and_return(false)
      end

      it "does not sign in" do
        post :create, params: { session: { name: brother.name, password: brother.password } }
        expect(cookies[:remember_token]).to be_nil
      end

      it "renders new template with error" do
        post :create, params: { session: { name: brother.name, password: brother.password } }
        expect(response).to render_template('new')
        expect(flash[:error]).to eq("CAPTCHA認証に失敗しました。もう一回お願いします!!!")
      end
    end
  end

  describe "DELETE 'destroy'" do
    before { sign_in_for_controller brother }

    it "signs out the brother" do
      delete :destroy, params: { id: brother.id }
      expect(cookies[:remember_token]).to be_nil
    end

    it "redirects to root path" do
      delete :destroy, params: { id: brother.id }
      expect(response).to redirect_to(root_path)
    end

    it "sets success flash message" do
      delete :destroy, params: { id: brother.id }
      expect(flash[:success]).to eq("!!!!!!!! またあおう !!!!!!!!")
    end
  end
end
