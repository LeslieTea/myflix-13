require 'spec_helper'

feature 'User invites friend' do
  scenario 'User successfully invites friend and invitation is accepted' do
    laura = Fabricate(:user)
    sign_in(laura)

    invite_a_friend
    friend_accepts_invitation
    friend_signs_in

    friend_should_follow(laura)

    inviter_should_follow_friend(laura)
    

    clear_email
  end

  def invite_a_friend
    visit new_invitation_path
    fill_in "Friend's name", with: "Royal Ranger"
    fill_in "Friend's Email Address", with: "royalranger@email.com"
    fill_in "message", with: "Join the App Ranger and Royal!"
    click_button "Send Invitation"
    sign_out
  end

  def friend_accepts_invitation
    open_email "royalranger@email.com"
    current_email.click_link "Accept this invitation"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "Royal Ranger"
    click_button "Sign Up"
  end

  def friend_signs_in
    visit sign_in_path
    fill_in "Email Address", with: "royalranger@email.com"
    fill_in "Password", with: "password"
    click_button "Sign in"
  end
  
  def friend_should_follow(user)
    click_link "People"
    expect(page).to have_content user.full_name
    sign_out
  end
  
  def inviter_should_follow_friend(inviter)
    sign_in(inviter)
    click_link "People"
    expect(page).to have_content "Royal Ranger"
  end
end
