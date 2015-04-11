require 'spec_helper'

describe PasswordResetsController do
  describe "GET show" do
    it "render view template if token is valid" do
      alice = Fabricate(:user, token: '12345')
      get :show, id: '12345'
      expect(response).to render_template :show
    end
    it "redirects to the expire token page if the token is invalid"
  end
end