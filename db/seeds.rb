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
             admin: true)
            
general_user = User.find_by(name:"general User")
55.times do
  name = Faker::Name.name
  content = Faker::Lorem.sentence(7)
  price=Faker::Number.between(50, 200)
  general_user.items.create!(name: name,category:"bb",content: content,price: price)
end

# users = User.order(:created_at).take(2)
# 50.times do
#   content = Faker::Lorem.sentence(5)
#   users.each { |user| user.items.create!(name:"name",category:"bb",content: content,price:0) }
# end

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "3passwordPass$"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
