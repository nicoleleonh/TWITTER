# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


img1 = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEAqn_crckafxpHYB1ZIfvE9U6u1TVLplVbA&usqp=CAU'
u1 = User.create(username: 'nicoleleonh', email: 'niki@prueba.com', profile_picture: img1, password: '123456', password_confirmation: '123456')


img2 = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRv2OdCp_JNOW_hI4zqR6k9_fetGtDhkpzSzg&usqp=CAU'
u2 = User.create(username: 'urania', email: 'uri@prueba.com', profile_picture: img2, password: '123456', password_confirmation: '123456')


img3= 'https://www.fanaticosdelasmascotas.cl/wp-content/uploads/2020/11/de-an-sun-unsplash_portada-1.jpg'
u3 = User.create(username: 'princesa', email: 'prin@prueba.com', profile_picture: img3, password: '123456', password_confirmation: '123456')


img4= 'https://nfnatcane.es/blog/wp-content/uploads/2020/10/perro-dalmata.jpg'
u4 = User.create(username: 'susy', email: 'susy@prueba.com', profile_picture: img4, password: '123456', password_confirmation: '123456')


20.times do |i|
    u1.tweets.create(content: "Tweet #{i}")
end

20.times do |i|
    u2.tweets.create(content: "Tweet #{i}")
end

20.times do |i|
    u3.tweets.create(content: "Tweet #{i}")
end

20.times do |i|
    u4.tweets.create(content: "Tweet #{i}")
end
