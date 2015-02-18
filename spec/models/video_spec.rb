require 'spec_helper'

describe Video do
  it { should belong_to(:category)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}
  
  describe "search_by_title" do
    it "returns an empty array if there is no match" do
      futurama = Video.create(title: "Futurama", description: "space travel")
      back_to_future = Video.create(title: "Back to the future", description: "Sci Fi")
      expect(Video.search_by_title("hello")).to eq([])
    end
    it "returns an array of one video for an exact match" do
      futurama = Video.create(title: "Futurama", description: "space travel")
      back_to_future = Video.create(title: "Back to the future", description: "Sci Fi")
      expect(Video.search_by_title("Futurama")).to eq([futurama])
    end
    it "returns an array of one video for a partial match" do
      futurama = Video.create(title: "Futurama", description: "space travel")
      back_to_future = Video.create(title: "Back to the future", description: "Sci Fi")
      expect(Video.search_by_title("Futur")).to eq([futurama])
    end
    it "returns an array of all matches ordered by created_at" do
      futurama = Video.create(title: "futurama", description: "space travel", created_at: 1.day.ago)
      back_to_future = Video.create(title: "Back to the future", description: "Sci Fi")
      expect(Video.search_by_title("futur")).to eq([futurama, back_to_future])
    end
  end
    

end