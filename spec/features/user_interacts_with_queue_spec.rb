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
    
    within(:xpath, "/tr[contains.,'#{monk.title}')]") do
      fill_in "queue_items[][position]", with: 3
    end
    
    within(:xpath, "/tr[contains.,'#{south_park.title}')]") do
      fill_in "queue_items[][position]", with: 1
    end
    
    within(:xpath, "/tr[contains.,'#{futurama.title}')]") do
      fill_in "queue_items[][position]", with: 2
    end
        
    click_button "Update Instant Queue"
    
    
    expect(find(:xpath, "/tr[contains(.,'#{south_park.title}')]//input[@type='text']").value).to eq("1")
    expect(find(:xpath, "/tr[contains(.,'#{futurama.title}')]//input[@type='text']").value).to eq("2")
    expect(find(:xpath, "/tr[contains(.,'#{monk.title}')]//input[@type='text']").value).to eq("3")
        
  end
end
