# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create(name: "drama")
Category.create(name: "comedy")
Category.create(name: "Reality TV")

Video.create(title: "Monk", 
	description: "my description of Monk",
	small_cover_url: "/tmp/monk.jpg",
	large_cover_url: "/tmp/monk.jpg",
	category_id: 1)
Video.create(title: "Family Guy",
	description: "my description of Family Guy",
	small_cover_url: "/tmp/family_guy.jpg",
	large_cover_url: "/tmp/family_guy.jpg",
	category_id: 2)
Video.create(title: "Futurama",
	description: "my description of Futurama",
	small_cover_url: "/tmp/futurama.jpg",
	large_cover_url: "/tmp/futurama.jpg",
	category_id: 3)
Video.create(title: "South Park",
	description: "my description of South Park",
	small_cover_url: "/tmp/south_park.jpg",
	large_cover_url: "/tmp/south_park.jpg",
	category_id: 2)