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
            
general_user = User.find(name:"general User")
50.times do
  name = Faker::Lorem.sentence(5)
  content = Faker::Lorem.sentence(7)
  general_user.items.create!(name: name,category:"bb",content: content,price:0)
end

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "passwordpass"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
