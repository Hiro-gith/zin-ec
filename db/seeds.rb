# データベース上にサンプルユーザーを作成する
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobarfoo",
             password_confirmation: "foobarfoo")

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "passwordpass"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
