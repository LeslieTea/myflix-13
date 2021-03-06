require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  
  describe "POST create" do
    context "with valid input" do
      before do
        post :create, user: Fabricate.attributes_for(:user)
      end
      it "creates the user" do
        expect(User.count).to eq(1)
      end
      
      it "redirects to sign in page" do
        expect(response).to redirect_to sign_in_path
      end
    end
    
    context "with invalid input" do
      before do
        post :create, user: { password: "password", full_name: "Leslie Turner" }
      end  
      it "doesn't create the user" do
        expect(User.count).to eq(0)
      end
      
      it "renders the :new template" do
        expect(response).to render_template :new
      end
      
      it "sets @user" do
        expect(response).to render_template :new
      end
    end
  end
  
  context "sending email" do
    
    after  { ActionMailer::Base.deliveries.clear }
    
    it "sends out email to the user with valid inputs" do
      post :create, user: { email: "leslie@example.com", password: "password", full_name: "leslie turner" }
      expect(ActionMailer::Base.deliveries.last.to).to eq(['leslie@example.com'])
    end
    
    it "sends out email containing users name" do
      post :create, user: { email: "leslie@example.com", password: "password", full_name: "leslie turner" }
      expect(ActionMailer::Base.deliveries.last.body).to include('leslie turner')
    end
  end
  
  describe "GET show" do
    it_behaves_like "requires sign in" do
      let(:action) { get :show, id: 3 }
    end
    
    it "sets @user" do
      set_current_user
      leslie = Fabricate(:user)
      get :show, id: leslie.id
      expect(assigns(:user)).to eq(leslie)
    end
  end
end


