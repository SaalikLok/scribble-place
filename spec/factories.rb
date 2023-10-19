FactoryBot.define do
  factory :user do
    email { "scribbler@scrompits.com" }
    password { "password" }
  end

  factory :scribble do
    content { "This is my scribble" }
    user
  end
end
