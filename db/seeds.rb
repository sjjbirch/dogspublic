# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create users
user_list = [
    [ 'test1@test.com', 'qwerty' ],
    [ 'test2@test.com', 'qwerty' ],
    [ 'test3@test.com', 'qwerty' ],
    [ 'test4@test.com', 'qwerty' ]
]

user_list.each do |email, password|
    User.create!( email: email, password: password, password_confirmation: password )
end

# create an admin
Admin.create!( email: 'admin@test.com', password: 'qwerty', password_confirmation: 'qwerty' )

# create three dogs
dog_list = user_list = [
    [ 'Doggo 1', 'Fido', 'John Smith', 'Mary Poppins', 'M', 1 ],
    [ 'Doggo 2', 'Lassie', 'James May', 'Sue Tylerson', 'F', 2 ],
    [ 'Doggo 3', 'Spot', 'DR Suess', 'Jamie Lannister', 'M', 3 ]
]

date = 1.year.ago
dog_list.each do |rname, cname, owner, handler, sex, account|
    dog = Dog.new( rname: rname, cname: cname, dob: date,
                    owner: owner, handler: handler, sex: sex, user_id: account )
    dog.save!
    date = date - 1.days
end

# create some payments
