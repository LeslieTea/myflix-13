require 'spec_helper'

feature 'User signs in' do 
  scenario "with valid email and password" do
    veronica = Fabricate(:user)
    sign_in(veronica)
    page.should have_content veronica.full_name
  end
end