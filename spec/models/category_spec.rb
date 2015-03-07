require 'spec_helper'

describe Category do
  it { should have_many(:videos)} 
  it { should validate_presence_of(:name) }
  
  describe "#recent_videos" do
    it "returns the videos in the reverse chronical order by created_at" do
    comedies = Category.create(name: "comedies")
    futurama = Video.create(title: "Futurama", description: "space travel", category: comedies, created_at: 1.day.ago)
    south_park = Video.create(title: "South Park", description: "Crazy kids", category: comedies)
    expect(comedies.recent_videos).to eq([south_park, futurama])
  end
    
    
   it "returns all the videos if there are less than 6 videos" do
    comedies = Category.create(name: "comedies")
    futurama = Video.create(title: "Futurama", description: "space travel", category: comedies, created_at: 1.day.ago)
    south_park = Video.create(title: "South Park", description: "Crazy kids", category: comedies)
    expect(comedies.recent_videos.count).to eq(2)
  end  
  it "returns only 6 videos if there are more than 6 videos in category" do
    comedies = Category.create(name: "comedies")
    7.times { Video.create(title: "Foo", description: "foo fighters", category: comedies)}
    expect(comedies.recent_videos.count).to eq(6)
  end
  
  it "returns most recent 6 videos" do
    comedies = Category.create(name: "comedies")
    6.times { Video.create(title: "Foo", description: "foo fighters", category: comedies)}
    tonights_show = Video.create(title: "Tonights show", description: "the show", category: comedies, created_at: 1.day.ago)
    expect(comedies.recent_videos).not_to include(tonights_show)
  end
  
  it "returns an empty array if the category doesn't have any videos" do
    reality = Category.create(name: "reality")
    expect(reality.recent_videos).to eq([])
  end
  end
end
