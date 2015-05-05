require 'spec_helper'

describe InvitationsController do
  describe "GET new" do
    it "sets @invitation to a new invitation" do
      set_current_user
    get :new
    expect(assigns[:invitation]).to be_new_record
    expect(assigns[:invitation]).to be_instance_of Invitation
  end
    
    it_behaves_like "requires sign in" do
      let(:action) { get :new }
    end
  end
  
  describe "POST create" do
    it_behaves_like "requires sign in" do
      let(:action) { post :create }
    end
    
    context "with valid input" do
      after { ActionMailer::Base.deliveries.clear } #clears email queue
      it "creates an invitation" do
        set_current_user
        post :create, invitation: { recipient_name: "Joe Smith", recipient_email: "joe@example.com", message: "Hey join Myflix!" }
        expect(Invitation.count).to eq(1)
      end
      
      it "sends an email to the recipient" do
        set_current_user
        post :create, invitation: { recipient_name: "Joe Smith", recipient_email: "joe@example.com", message: "Hey join Myflix!" }
        expect(ActionMailer::Base.deliveries.last.to).to eq(["joe@example.com"])
      end
      
      it "redirects to the invitation new page" do
        set_current_user
        post :create, invitation: { recipient_name: "Joe Smith", recipient_email: "joe@example.com", message: "Hey join Myflix!" }
        expect(response).to redirect_to new_invitation_path
      end
      
      it "sets the flash success message" do
        set_current_user
        post :create, invitation: { recipient_name: "Joe Smith", recipient_email: "joe@example.com", message: "Hey join Myflix!" }
        expect(flash[:success]).to be_present
      end
    end
    context "with invalid input" do
      it "renders the :new template" do
        set_current_user
        post :create, invitation: {  recipient_email: "joe@example.com", message: "Hey join Myflix!" }
        expect(response).to render_template :new
      end
      
      it "doesnt create an invitation" do
        set_current_user
        post :create, invitation: {  recipient_email: "joe@example.com", message: "Hey join Myflix!" }
        expect(Invitation.count).to eq(0)
      end
              
      it "doesnt send out an email" do
        set_current_user
        post :create, invitation: {  recipient_email: "joe@example.com", message: "Hey join Myflix!" }
        expect(ActionMailer::Base.deliveries).to be_empty
      end
      
      it "sets the flash error message" do
        set_current_user
        post :create, invitation: {  recipient_email: "joe@example.com", message: "Hey join Myflix!" }
        expect(flash[:error]).to be_present
      end
      
      it "sets @invitation" do
        set_current_user
        post :create, invitation: {  recipient_email: "joe@example.com", message: "Hey join Myflix!" }
        expect(assigns(:invitation)).to be_present
      end
    end
    
    describe "GET new_with_invitation token" do
      it "sets @user with recipients email" do
        invitation = Fabricate(:invitation)
        get :new_with_invitation_token, token: invitation.token
        expect(assigns(:user).email).to eq(invitation.recipient_email)
      end
      
      it "redirects to expired token age for invalid tokens"
      
    end
  end
end