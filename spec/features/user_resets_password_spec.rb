require 'spec_helper'

feature 'User resets password' do
  scenario 'user successfully resets password' do
    laura = Fabricate(:user, password: 'old_password')
    visit sign_in_path
    click_link "Forgot Password?"
    fill_in "Email Address", with: laura.email
    click_button "Send Email"

    open_email(laura.email)
    current_email.click_link 'Reset My Password'

    fill_in "New Password", with: "new_password"
    click_button "Reset Password"
    
    #save_and_open_page

    fill_in "Email", with: laura.email
    fill_in "Password", with: "new_password"
    click_button "Sign in"

    expect(page).to have_content("Welcome, #{laura.full_name}")
  end
end

# How to move forward
# Letter_opener_web is clearly not working in nitrous. Neither is this spec passing, which I suspect has something to do with letter_opener not functioning.
#     I must move on. In order to move on, delete this spec and forget about letter opener opening up seamlessley as it's supposed to'