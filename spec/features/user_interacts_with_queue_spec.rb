require 'spec_helper'

feature "User interacts with the queue" do
  scenario "user adds and reorders videos in the queue" do
    
    category    = Fabricate(:category)
    monk        = Fabricate(:video, title: 'monk', category: category)
    futurama    = Fabricate(:video, title: 'futurama', category: category)
    south_park  = Fabricate(:video, title: 'south park', category: category)
        
    sign_in
    find("a[href='/videos/#{monk.id}']").click
    page.should have_content(monk.title)
    
    click_link "+ My Queue"
    page.should have_content(monk.title)
    
    visit video_path(monk)
    page.should_not have_content "+ My Queue"
    
    visit home_path
    find("a[href='/videos/#{south_park.id}']").click
    click_link "+ My Queue"
    visit home_path
    find("a[href='/videos/#{futurama.id}']").click
    click_link "+ My Queue"
    
    fill_in "video_#{monk.id}", with: 3
    fill_in "video_#{south_park.id}", with: 1
    fill_in "video_#{futurama.id}", with: 2
    
    click_button "Update Instant Queue"
    
    expect(find("#video_#{south_park.id}").value).to eq("1")
    expect(find("#video_#{futurama.id}").value).to eq("2")
    expect(find("#video_#{monk.id}").value).to eq("3")
    
  end
end