# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Creating users'
user_list = [
    [ 'test1@test.com', 'qwerty' ],
    [ 'test2@test.com', 'qwerty' ],
    [ 'test3@test.com', 'qwerty' ],
    [ 'test4@test.com', 'qwerty' ]
]

user_list.each do |email, password|
    User.create!( email: email, password: password, password_confirmation: password )
end

puts 'Creating an admin'
Admin.create!( email: 'admin@test.com', password: 'qwerty', password_confirmation: 'qwerty' )

puts 'Creating dogs'
dog_list = [
    [ 'Doggo 1', 'Fido', 'John Smith', 'Mary Poppins', 'M', 1 ],
    [ 'Doggo 2', 'Lassie', 'James May', 'Sue Tylerson', 'F', 2 ],
    [ 'Doggo 3', 'Spot', 'DR Suess', 'Jamie Lannister', 'M', 3 ]
]

date = 1.year.ago
dog_list.each do |rname, cname, owner, handler, sex, account|
    dog = Dog.new( rname: rname, cname: cname, dob: date,
                    owner: owner, handler: handler, sex: sex, user_id: account )
    dog.save!
    date = date - 45.days
end

puts 'Creating some payments'
payment_list = [
    [ 2, 1, 1 ],
    [ 1, 2, 3 ],
    [ 2, 3, 3 ],
    [ 3, 2, 2 ]
]

payment_list.each do | seller, buyer, dog |
    payment = Payment.new( seller_id: seller, buyer_id: buyer, dogsold: dog, transaction_time: Time.now )
    payment.save!
end

puts 'Advertising one of the dogs'

Advert.create( dog_id: 1, title: 'Attempting to sell dog 1', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum fermentum dui quis sem dictum, at ultricies dolor malesuada. Sed ut maximus tellus, at hendrerit leo. Sed posuere scelerisque sem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Aliquam ultrices a neque quis aliquet. Praesent placerat blandit elit a ultrices. Donec magna nibh, malesuada sit amet ornare in, convallis nec mauris. ')

puts 'Creating a litter'
Litter.create!( planned_date: 386.days.ago, expected_date: 383.days.ago, 
                actual_date: 384.days.ago, expected_size: 8, actual_size: 6,
                identifier: 'CuteLitter' )

puts 'Adding active storage pictures to the litter'

@litter = Litter.first
@litter.gallery_image.attach(io: File.open(Rails.root.join("app", "assets", "images", "Pic1.jpg")),
                            filename: 'Pic1.jpg', content_type: 'image/jpeg')
@litter.gallery_image.attach(io: File.open(Rails.root.join("app", "assets", "images", "Pic2.png")),
                            filename: 'Pic1.jpg', content_type: 'image/jpeg')
@litter.gallery_image.attach(io: File.open(Rails.root.join("app", "assets", "images", "Pic3.gif")),
                            filename: 'Pic1.jpg', content_type: 'image/jpeg')

puts 'Seeded database for your pleasure'