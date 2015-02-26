require 'spec_helper'
describe Video do 
  
#   describe "#display_text" do
#     it "displays the name when theres no categories" do
#       video = Video.create(title: "Dogs")
#       video.display_text.should == 'Dogs'
#     end
#     it "displays the only video with title when there is a category" do
#       drama = Category.create(name: "drama")
#       video = Video.create(title: "Dogs", category: drama)
#       video.display_text.should == 'Dogs  (category: drama)'
#     end
#     it "displays name with multiple categories" do
#       drama = Category.create(name: "drama")
#       comedy = Category.create(name: "comedy")
#       video = Video.create(title: "Dogs")
#       video.display_text.should == "Dogs  (category: drama, comedy)"
 
#     end
#     it "displays up to four categories" do
#       video = Video.create(title: "Dogs")
#       video.category.create(name: "drama")
#       video.category.create(name: "comedy")
#       video.category.create(name: "family")
#       video.category.create(name: "fun")
#       video.display_text.should == "Dogs (category: drama, comedy, family, fun)"
#     end
  
# end
	
	# it "belongs to category" do
	# 	dramas = Category.create(name: "dramas")
	# 	monk = Video.create(title: "Monk", description: "my monk", category: dramas)
	# 	expect(monk.category).to eq(dramas)
	# end

	it { should belong_to(:category)}
 	it { should validate_presence_of(:title)}
 	it { should validate_presence_of(:description)}

 
 	describe "search_by_title" do
 		it "returns an empty array if there is no match" do
 			futurama = Video.create(title: "Futurama", description: "Space travel")
 			back_to_future = Video.create(title: "Back to Future", description: "Time travel")
 		expect(Video.search_by_title("hello")).to eq([])
 		end



 		it "returns an array of one video for a partial match" do
 			futurama = Video.create(title: "Futurama", description: "Space travel")
 			back_to_future = Video.create(title: "Back to Future", description: "Time travel")
 			expect(Video.search_by_title("urama")).to eq([futurama])
 		end

 		it "returns an array of all matches ordered by created_at" do
 			futurama = Video.create(title: "Futurama", description: "Space travel", created_at: 1.day.ago)
 			back_to_future = Video.create(title: "Back to Future", description: "Time travel")
 			expect(Video.search_by_title("Futur")).to eq([back_to_future, futurama])
 		end
 		it "returns an empty array for a search with an empty string" do
 			futurama = Video.create(title: "Futurama", description: "Space travel", created_at: 1.day.ago)
 			back_to_future = Video.create(title: "Back to Future", description: "Time travel")
 			expect(Video.search_by_title("")).to eq([])
 		end
 	end	
end