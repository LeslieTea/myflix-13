require 'spec_helper'

feature "User interacts with the queue" do
  scenario "user adds and reorders videos in the queue" do
    
    category    = Fabricate(:category)
    monk        = Fabricate(:video, title: 'monk', category: category)
    futurama    = Fabricate(:video, title: 'futurama', category: category)
    south_park  = Fabricate(:video, title: 'south park', category: category
     
        
    sign_in
    page.should have_content(monk.title)
  end
end