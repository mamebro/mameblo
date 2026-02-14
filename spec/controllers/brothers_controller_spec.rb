require 'spec_helper'

describe BrothersController, type: :controller do
  let(:brother) { create(:brother) }

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      expect(response.response_code).to eq 200
    end
  end

  describe "GET 'following'" do
    it "returns success" do
      sign_in_for_controller brother
      get 'following', params: { id: brother.id }
      expect(response.response_code).to eq 200
    end
  end

  describe "GET 'follower'" do
    it "returns success" do
      sign_in_for_controller brother
      get 'followers', params: { id: brother.id }
      expect(response.response_code).to eq 200
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get :show, params: { id: brother.name }
      expect(response.response_code).to eq 200
    end

    it "assigns the brother" do
      get :show, params: { id: brother.name }
      expect(assigns(:brother)).to eq(brother)
    end

    it "assigns the brother's entries" do
      entry = create(:entry, brother: brother)
      get :show, params: { id: brother.name }
      expect(assigns(:entries)).to include(entry)
    end
  end

  describe "GET 'index'" do
    context "when not signed in" do
      it "redirects to signin page" do
        get :index
        expect(response).to redirect_to(signin_path)
      end
    end

    context "when signed in" do
      before { sign_in_for_controller brother }

      it "returns http success" do
        get :index
        expect(response.response_code).to eq 200
      end

      it "assigns brothers" do
        get :index
        expect(assigns(:brothers)).to include(brother)
      end

      it "responds to JSON format" do
        get :index, params: { format: :json }
        expect(response.response_code).to eq 200
      end
    end
  end

  describe "POST 'create'" do
    before do
      allow(CaptchaService).to receive(:validate).and_return(true)
    end

    context "with valid params" do
      it "creates a new brother" do
        expect {
          post :create, params: { brother: { name: 'newbro', email: 'new@example.com',
                                             password: 'foobar', password_confirmation: 'foobar' } }
        }.to change(Brother, :count).by(1)
      end

      it "redirects to root path" do
        post :create, params: { brother: { name: 'newbro', email: 'new@example.com',
                                           password: 'foobar', password_confirmation: 'foobar' } }
        expect(response).to redirect_to(root_path)
      end

      it "sets success flash message" do
        post :create, params: { brother: { name: 'newbro', email: 'new@example.com',
                                           password: 'foobar', password_confirmation: 'foobar' } }
        expect(flash[:success]).to eq("!!! まめぶろにようこそ !!!")
      end

      it "signs in the new brother" do
        post :create, params: { brother: { name: 'newbro', email: 'new@example.com',
                                           password: 'foobar', password_confirmation: 'foobar' } }
        expect(cookies[:remember_token]).to be_present
      end
    end

    context "with invalid params" do
      it "does not create a new brother" do
        expect {
          post :create, params: { brother: { name: '', email: '', password: '', password_confirmation: '' } }
        }.not_to change(Brother, :count)
      end

      it "renders new template" do
        post :create, params: { brother: { name: '', email: '', password: '', password_confirmation: '' } }
        expect(response).to render_template('new')
      end
    end

    context "with invalid captcha" do
      before do
        allow(CaptchaService).to receive(:validate).and_return(false)
      end

      it "does not create a new brother" do
        expect {
          post :create, params: { brother: { name: 'newbro', email: 'new@example.com',
                                             password: 'foobar', password_confirmation: 'foobar' } }
        }.not_to change(Brother, :count)
      end

      it "renders new template with error" do
        post :create, params: { brother: { name: 'newbro', email: 'new@example.com',
                                           password: 'foobar', password_confirmation: 'foobar' } }
        expect(response).to render_template('new')
        expect(flash.now[:error]).to eq("CAPTCHA認証に失敗しました。もう一回お願いします!!!")
      end
    end
  end

  describe "GET 'edit'" do
    context "when not signed in" do
      it "redirects to signin page" do
        get :edit, params: { id: brother.id }
        expect(response).to redirect_to(signin_path)
      end
    end

    context "when signed in as correct brother" do
      before { sign_in_for_controller brother }

      it "returns http success" do
        get :edit, params: { id: brother.id }
        expect(response.response_code).to eq 200
      end
    end

    context "when signed in as different brother" do
      let(:other_brother) { create(:brother) }
      before { sign_in_for_controller other_brother }

      it "redirects to root path" do
        get :edit, params: { id: brother.id }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "PATCH 'update'" do
    context "when not signed in" do
      it "redirects to signin page" do
        patch :update, params: { id: brother.id, brother: { password: 'newpass', password_confirmation: 'newpass' } }
        expect(response).to redirect_to(signin_path)
      end
    end

    context "when signed in as correct brother" do
      before { sign_in_for_controller brother }

      context "with valid params" do
        it "updates the brother" do
          patch :update, params: { id: brother.id, brother: { name: brother.name, email: brother.email,
                                                              password: 'newpass', password_confirmation: 'newpass' } }
          expect(flash[:success]).to eq("!!! パスワード変更しました !!!")
        end

        it "redirects to edit page" do
          patch :update, params: { id: brother.id, brother: { name: brother.name, email: brother.email,
                                                              password: 'newpass', password_confirmation: 'newpass' } }
          expect(response).to redirect_to(edit_brother_path)
        end
      end

      context "with invalid params" do
        it "renders edit template" do
          patch :update, params: { id: brother.id, brother: { password: 'a', password_confirmation: 'b' } }
          expect(response).to render_template('edit')
        end
      end
    end
  end
end
