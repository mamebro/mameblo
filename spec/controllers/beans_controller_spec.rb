require 'spec_helper'

describe BeansController, type: :controller do
  let(:brother) { create(:brother) }
  let(:entry) { create(:entry, brother: brother) }

  describe "POST 'create'" do
    before { sign_in_for_controller brother }

    it "creates a new bean" do
      expect {
        post :create, params: { entry_id: entry.id }
      }.to change(Bean, :count).by(1)
    end

    it "associates the bean with the correct entry" do
      post :create, params: { entry_id: entry.id }
      expect(Bean.last.entry_id).to eq(entry.id)
    end

    it "sets throw_brother_id to current brother" do
      post :create, params: { entry_id: entry.id }
      expect(Bean.last.throw_brother_id).to eq(brother.id)
    end
  end
end
