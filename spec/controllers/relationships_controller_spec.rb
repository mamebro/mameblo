require 'spec_helper'

describe RelationshipsController do

  let(:brother) { FactoryGirl.create(:brother) }
  let(:other_brother) { FactoryGirl.create(:brother) }

  before { sign_in brother }

  describe "creating a relationship with Ajax" do

    it "should increment the Relationship count" do
      expect do
        xhr :post, :create, relationship: { followed_id: other_brother.id }
      end.to change(Relationship, :count).by(1)
    end
  end

  describe "destroying a relationship with Ajax" do

    before { brother.follow!(other_brother) }
    let(:relationship) { brother.relationships.find_by_followed_id(other_brother) }

    it "should decrement the Relationship count" do
      expect do
        xhr :delete, :destroy, id: relationship.id
      end.to change(Relationship, :count).by(-1)
    end
  end
end
