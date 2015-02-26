require 'spec_helper'

describe VideosController do
  describe "GET show" do
    context "with authenticated users" do
      before do
        session[:user_id] = Fabricate(:user).id
      end
      it "sets @video" do
        video = Fabricate(:video)
        get :show, id: video.id
        expect(assigns(:video)).to eq(video)
      end

      context "with unauthenticated users" do
        it "redirects user to sign in page" do
          video = Fabricate(:video)
          get :show, id: video.id
          expect(response).to redirect_to sign_in_path
        end
      end
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
end