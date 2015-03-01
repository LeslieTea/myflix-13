require 'spec_helper'

describe VideosController do
  describe "GET show" do
    it "sets @video if user is authenticated" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
      end
    
    it "sets @reviews for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      get :show, id: video.id
      expect(assigns(:reviews)).to match_array([review1, review2]) 
    end

   it "redirects user to sign in page if user is not authenticated" do
     video = Fabricate(:video)
     get :show, id: video.id
     expect(response).to redirect_to sign_in_path
   end
   end
  
  describe "POST search" do
    it "sets @results for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      futurama = Fabricate(:video, title: 'Futurama')
      post :search, search_term: 'rama'
      expect(assigns(:results)).to eq([futurama])
    end
  end
  

  it "redirects to sign in page for unauthenticated users" do
    futurama = Fabricate(:video, title: 'Futurama')
    post :search, search_term: 'rama'
    expect(response).to redirect_to sign_in_path
  end

end



    


  
#   describe "GET new" do
#     it "sets the @video variable" do
#       futurama = Video.create(title: "futurama", description: "in the future")
            
#       get :new
#       assigns(:video).should be_new_record
#       assigns(:video).should be_instance_of(Video)
#     end
#     it "renders the new template" do
#       get :new
#       response.should render_template :new
#     end
#   end
  
#   #describe "POST create" do
#    # it "creates the category record when the input is valid" do
#      # post :create, category: {name: "drama" }
#      # Category.first.name.should == "drama"
#     #end
#     #it "redirects to the root path when the input is valid"
#       #post :create, category: {name: "drama"} do
#       #response.should redirect_to root_path
#     #end
#     #it "renders the new template when the input is invalid"
#   #end
#end