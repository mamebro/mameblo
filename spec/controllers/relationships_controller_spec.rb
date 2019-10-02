require 'spec_helper'

describe RelationshipsController, type: :controller do

  let(:brother) { create(:brother) }
  let(:other_brother) { create(:brother) }

  before { sign_in_for_controller brother }

  describe "creating a relationship with Ajax" do

    it "should increment the Relationship count" do
      expect do
        post :create, xhr: true, params: { relationship: { followed_id: other_brother.id } }
      end.to change(Relationship, :count).by(1)
    end
  end

  describe "destroying a relationship with Ajax" do

    before { brother.follow!(other_brother) }
    let(:relationship) { brother.relationships.find_by_followed_id(other_brother) }

    it "should decrement the Relationship count" do
      expect do
        delete :destroy, xhr: true, params: { id: relationship.id }
      end.to change(Relationship, :count).by(-1)
    end
  end
end
