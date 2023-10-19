# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require "faker"

User.delete_all
Scribble.delete_all

user = User.create(email: "superscribbler@lokbros.com", password: "password")

50.times do
  Scribble.create(content: Faker::Quote.yoda, user_id: user.id)
end
