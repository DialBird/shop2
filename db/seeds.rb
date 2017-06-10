# user
User.create(email: 'tekitou@co.jp', password: 'password')

# product
Product.create(name: 'りんご', price: 200, cost: 100, image: File.open("#{Rails.root}/db/data/apple.jpg"))
Product.create(name: 'バナナ', price: 100, cost: 50, image: File.open("#{Rails.root}/db/data/banana.jpg"))
Product.create(name: 'ぶどう', price: 500, cost: 20, image: File.open("#{Rails.root}/db/data/grape.jpg"))
