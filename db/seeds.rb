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

admin_user = User.find_by(name:"admin User")
30.times do
  name = Faker::Device.model_name
  content = Faker::Lorem.sentence(word_count:7)
  price=Faker::Number.between(from: 5000, to: 20000)
  quantity=Faker::Number.between(from: 0, to: 100)
  admin_user.items.create!(name: name,category:"家電",content: content,price: price,sales: quantity)
end

            
general_user = User.find_by(name:"general User")

30.times do
  name = Faker::Food.fruits
  content = Faker::Lorem.sentence(word_count:7)
  price=Faker::Number.between(from: 50, to: 300)
  general_user.items.create!(name: name,category:"食品",content: content,price: price)
end


30.times do
  name = Faker::Vehicle.manufacture
  content = Faker::Lorem.sentence(word_count:7)
  price=Faker::Number.between(from: 100000, to: 300000)
  general_user.items.create!(name: name,category:"乗り物",content: content,price: price)
end

15.times do
  name = Faker::Food.fruits
  content = Faker::Lorem.sentence(word_count:7)
  price=Faker::Number.between(from: 50, to: 300)
  general_user.items.create!(name: name,category:"食品",content: content,price: price,spoint: 40)
end

15.times do
  name = Faker::Vehicle.manufacture
  content = Faker::Lorem.sentence(word_count:7)
  price=Faker::Number.between(from: 100000, to: 300000)
  general_user.items.create!(name: name,category:"乗り物",content: content,price: price,spoint: 30)
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

# リレーションシップ
users = User.all
following = users[2..50]
followers = users[3..40]
# general_userにフォロー・フォロワーを作る
following.each { |followed| general_user.follow(followed) }
followers.each { |follower| follower.follow(general_user) }