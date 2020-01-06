# データベース上にサンプルユーザーを作成する

# 管理者ユーザー
User.create!(name:  "admin User",
             email: "admin@arazin.org",
             password:              "arazinzinA",
             password_confirmation: "arazinzinA",
             admin: true)

# 一般ユーザー             
User.create!(name:  "general User",
             email: "general@arazin.org",
             password:              "arazinzinG",
             password_confirmation: "arazinzinG",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "passwordpass"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
