require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    it "sets @queue_items to the queue items of the logged in user" do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      queue_item1 = Fabricate(:queue_item, user: alice)
      queue_item2 = Fabricate(:queue_item, user: alice)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end
    
    it "redirects to sign in page for unauthenticated users" do
      get :index
      expect(response).to redirect_to sign_in_path
    end
     
  end
  
  describe "POST create" do
    it "redirects to my queue page" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end
    it "creates a queue item" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end
    it "creates the queue item that is associated with the video" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end
    
    it "creates queue item that associated with the user" do
      leslie = Fabricate(:user)
      session[:user_id] = leslie.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(leslie)
    end
    it "puts the video as the last one in the queue" do
      leslie = Fabricate(:user)
      session[:user_id] = leslie.id
      monk = Fabricate(:video)
      Fabricate(:queue_item, video: monk, user: leslie)
      south_park = Fabricate(:video)
      post :create, video_id: south_park.id
      south_park_queue_item = QueueItem.where(video_id: south_park.id, user_id: leslie.id).first
      expect(south_park_queue_item.position).to eq("2")
    end
    it "doesnt add a video tto the queue if the video is already in queue" do
      leslie = Fabricate(:user)
      session[:user_id] = leslie.id
      monk = Fabricate(:video)
      Fabricate(:queue_item, video: monk, user: leslie)
      post :create, video_id: monk.id
      expect(leslie.queue_items.count).to eq(1)
    end
      
    it "redirects to the sign in for unauthenticated users" do
      post :create, video_id: 3
      expect(response).to redirect_to sign_in_path
    end
  end
  
  describe "DELETE destroy" do
    it "redirects to my queue page" do
      session[:user_id] = Fabricate(:user).id
      queue_item = Fabricate(:queue_item)
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to my_queue_path
    end
    it "deletes queue item" do
      leslie = Fabricate(:user)
      session[:user_id] = leslie.id
      queue_item = Fabricate(:queue_item, user: leslie)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(0)
    end
   
    it "doesn't delete the queue item if queue item isnt in the current users queue" do
      leslie = Fabricate(:user)
      bob = Fabricate(:user)
      session[:user_id] = leslie.id
      queue_item = Fabricate(:queue_item, user: bob)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(1)
    end
    it "redirects the sign in page for unauthenticated users" do
      delete :destroy, id: 3
      expect(response).to redirect_to sign_in_path
    end
  end  
end