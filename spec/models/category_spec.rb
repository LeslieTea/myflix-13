require 'spec_helper'

describe Category do
  it "saves itself" do
    category = Category.new(name: "comedies")
    category.save
    expect(Category.first).to eq(category)
  end

  it "has many videos" do
    comedies = Category.create(id: 1, name: "comedies")
    south_park = Video.create(title: "South Park", description: "Funny!", category_id: 1)
    futurama = Video.create(title: "Futurama", description: "Space travel", category_id: 1)    
    expect(comedies.videos).to eq([futurama, south_park])
  end
end