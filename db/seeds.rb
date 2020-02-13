# データベース上にサンプルユーザーを作成する

# 管理者ユーザー
User.create!(name:  "admin User",
             email: "admin@arazin.org",
             password:              "1arazinzinA$",
             password_confirmation: "1arazinzinA$",
             admin: true)

# 一般ユーザー             
User.create!(name:  "general User",
             email: "general@arazin.org",
             password:              "2arazinzinG$",
             password_confirmation: "2arazinzinG$",
             admin: false)
            
general_user = User.find_by(name:"general User")
55.times do
  name = Faker::Food.fruits
  content = Faker::Lorem.sentence(word_count:7)
  price=Faker::Number.between(from: 50, to: 200)
  general_user.items.create!(name: name,category:"bb",content: content,price: price)
end

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "3passwordPass$"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
