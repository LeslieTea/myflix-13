require 'spec_helper'

feature "User interacts with the queue" do
  scenario "user adds and reorders videos in the queue" do
    
    comedies    = Fabricate(:category)
    monk        = Fabricate(:video, title: "Monk", category: comedies)
    south_park  = Fabricate(:video, title: "South Park", category: comedies)
    futurama    = Fabricate(:video, title: "Futurama", category: comedies)
    
    sign_in
    
    add_video_to_queue(monk)
    expect_video_to_be_in_queue(monk)
        
    visit video_path(monk)
    expect_link_not_to_be_seen("+ My Queue")
        
    add_video_to_queue(futurama)
    add_video_to_queue(south_park)

    set_video_order(monk, 3)
    set_video_order(futurama, 1)
    set_video_order(south_park, 2)

    update_queue
    
    expect_video_order(monk, 3)
    expect_video_order(futurama, 1)
    expect_video_order(south_park, 2)
  end

def expect_video_to_be_in_queue(video)
  page.should have_content(video.title)
end

def expect_link_not_to_be_seen(link_text)
  page.should_not have_content(link_text)
end

def update_queue
  click_button "Update Instant Queue"
end

def add_video_to_queue(video)
  visit home_path
  click_on_video_on_home_page(video)
  expect(page).to have_content(video.title)
  click_link '+ My Queue'
end

  def set_video_order(video, position)
  within(:xpath, "//tr[contains(.,'#{video.title}')]") do
    fill_in "queue_items[][position]", with: position
  end
end

def expect_video_order(video, position)
  expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq(position.to_s)
end
end