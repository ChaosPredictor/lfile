case Rails.env
when "development"

	User.create!(
		name: "Example User",
		email: "example@railstutorial.org",
		password: "foobar",
		password_confirmation: "foobar",
		admin: true,
		activated: true,
		activated_at: Time.zone.now
		)

	User.create!(
		name: "DK",
		email: "kuzi81@gmail.com",
		password: "12345678",
		password_confirmation: "12345678",
		admin: true,
		activated: false,
		activated_at: Time.zone.now
		)

	99.times do |n|
		name = Faker::Name.name
		email = "example-#{n+1}@railstutorial.org"
		password = "password"
		User.create!(
			name: name,
			email: email,
			password: password,
			password_confirmation: password,
			activated: true,
			activated_at: Time.zone.now
			)
	end

	# Microposts
	users = User.order(:created_at).take(6)
	50.times do
	  content = Faker::Lorem.sentence(5)
	  users.each { |user| user.microposts.create!(content: content) }
	end

	# Following relationships
	users = User.all
	user = users.first
	following = users[2..50]
	followers = users[3..40]
	following.each { |followed| user.follow(followed) }
	followers.each { |follower| follower.follow(user) }


	#Instalation
	Instalation.create!(
	  name: "GIMP",
	  version: "1.1",
	  os: "linux"
		)

	Instalation.create!(
	  name: "Firefox",
	  version: "40.1",
	  os: "linux"
		)

	Instalation.create!(
	  name: "VLC",
	  version: "4.1",
	  os: "linux"
		)

	#Line
	Line.create!(
	  content: "sudo apt-get update",
	  index: 0
		)


	Line.create!(
	  content: "line for test 2",
	  index: 2
		)

	Line.create!(
	  content: "line for test 3",
	  index: 3
		)

	Line.create!(
	  content: "line for test 4",
	  index: 4
		)


	#Step

	Step.create!(
		instalation_id: 1,
		line_id: 3,
		order: 0
		)


	Step.create!(
		instalation_id: 1,
		line_id: 1,
		order: 1
		)

	Step.create!(
		instalation_id: 1,
		line_id: 2,
		order: 3
		)

	Step.create!(
		instalation_id: 1,
		line_id: 3,
		order: 5
		)

	Step.create!(
		instalation_id: 1,
		line_id: 4,
		order: 7
		)

	Step.create!(
		instalation_id: 1,
		line_id: 3,
		order: 8
		)

	Step.create!(
		instalation_id: 1,
		line_id: 2,
		order: 6
		)

	Step.create!(
		instalation_id: 1,
		line_id: 1,
		order: 4
		)

	Step.create!(
		instalation_id: 1,
		line_id: 4,
		order: 2
		)

	Step.create!(
		instalation_id: 1,
		line_id: 1,
		order: 9
		)

	Step.create!(
		instalation_id: 1,
		line_id: 3,
		order: 10
		)

	Step.create!(
		instalation_id: 2,
		line_id: 1,
		order: 0
		)

	Step.create!(
		instalation_id: 2,
		line_id: 4,
		order: 1
		)

	Step.create!(
		instalation_id: 2,
		line_id: 2,
		order: 2
		)

	Step.create!(
		instalation_id: 2,
		line_id: 3,
		order: 3
		)

when "production"
	
	User.create!(
		name: "Chaos Predictor",
		email: "kuzi81@gmail.com",
		password_digest: "$2a$10$QheUufgNXsJIPkzpBLNRHeLRX66A.U4pgm5azqz3Hd0UMYUw5ygIi",
		admin: true,
		activated: true,
		activated_at: Time.zone.now
		)

end
