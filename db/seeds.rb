# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env == "development"
    User.destroy_all
    user = User.create!({ email: "test@example.com", password: "password" })
    Profile.destroy_all
    Profile.create!({ id: 1, first_name: "Lorem", last_name: "Ipsum", user: user })
end