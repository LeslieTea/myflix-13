require 'spec_helper'

describe RelationshipsController do
  describe "GET index" do
    it "sets @relationships to the current user following relationships" do
      leslie = Fabricate(:user)
      set_current_user(leslie)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: leslie, leader: bob)
      get :index
      expect(assigns(:relationships)).to eq([relationship])
    end
    
    it_behaves_like "requires sign in" do
      let(:action) { get :index }
    end
  end
  
  describe "DELETE destroy" do
    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, id: 4 }
    end
    it "deletes the relationship if current user is the follower" do
      leslie = Fabricate(:user)
      set_current_user(leslie)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: leslie, leader: bob)
      delete :destroy, id: relationship
      expect(Relationship.count).to eq(0)
    end
      
    
    it "redirects to the people page" do
      leslie = Fabricate(:user)
      set_current_user
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: leslie, leader: bob)
      delete :destroy, id: relationship
      expect(response).to redirect_to people_path
    end
    it "doesnt delete the relationship if the current user isn't the follower" do
      leslie = Fabricate(:user)
      set_current_user(leslie)
      bob = Fabricate(:user)
      charlie = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: charlie, leader: bob)
      delete :destroy, id: relationship
      expect(Relationship.count).to eq(1)
    end
  end
end