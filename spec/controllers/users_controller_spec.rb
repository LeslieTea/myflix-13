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
      
    context "when new user visits via an invite" do
      let(:laura) { Fabricate(:user) }
      let(:invitation) { Fabricate(:invitation, inviter_id: laura.id, recipient_email: 'ryan@email.com') }

      before { post :create, user: {email: 'ryan@email.com', password: "password", full_name: 'Ry Dog'}, invitation_token: invitation.token }

      it "makes the user follow the inviter" do
        ryan = User.find_by_email('ryan@email.com')
        expect(ryan.follows?(laura)).to be_truthy
      end

      it "makes the inviter follow the user" do
        ryan = User.find_by_email('ryan@email.com')
        expect(laura.follows?(ryan)).to be_truthy
      end
      
      it "Expires the invitation upon acceptance" do
        expect(Invitation.first.token).to be_nil
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
  
  describe "GET new_with_invitation token" do
    it "renders the :new view template" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(response).to render_template :new
    end

    it "sets @user with recipients email" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:user).email).to eq(invitation.recipient_email)
    end
    
    it "sets @invitation_token" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:invitation_token)).to eq(invitation.token)
    end
      
    it "redirects to expired token page for invalid tokens" do
      get :new_with_invitation_token, token: 'asdsafda'
      expect(response).to redirect_to expired_token_path
    end
      
 
  end
end


