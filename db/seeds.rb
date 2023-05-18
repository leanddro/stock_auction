#Admin 1
admir = User.create!(name: 'Admir', cpf: '054.732.630-03', email: 'admir@leilaodogalpao.com.br', password: 'password')
#Admin 2
ana = User.create!(name: 'Ana', cpf: '498.265.430-12', email: 'ana@leilaodogalpao.com.br', password: 'password')

#Regular 1
leandro = User.create!(name: 'Leandro', cpf: '713.289.120-00', email: 'leandro@email.com', password: 'password')
#Regular 2
joao = User.create!(name: 'João', cpf: '495.820.520-90', email: 'joao@email.com', password: 'password')

#Categoria 1
category_1 = Category.create!(name: 'Eletrônico', description: 'A categoria de Eletrônicos engloba uma grande variedade de produtos, como smartphones, notebooks, acessórios, equipamentos de áudio e vídeo e aparelhos eletrônicos em gera')

#Itens
item_1 = Item.create!(name: 'Notebook Gamer Acer Nitro 5', description: 'Intel Core i7-11800H, GeForce GTX 1650, 8GB RAM, SSD 512GB, 15.6 Full HD 144Hz IPS, Windows 11, Preto - AN515-57-740K', weight: 2300, width: 363.4, height: 24.35, depth: 255, category: category_1, create_by: admir)
item_2 = Item.create!(name: 'Notebook Gamer Acer Nitro 5', description: 'Intel Core i7-11800H, GeForce GTX 1650, 8GB RAM, SSD 512GB, 15.6 Full HD 144Hz IPS, Windows 11, Preto - AN515-57-740K', weight: 2300, width: 363.4, height: 24.35, depth: 255, category: category_1, create_by: admir)
item_3 = Item.create!(name: 'Notebook Gamer Acer Nitro 5', description: 'Intel Core i7-11800H, GeForce GTX 1650, 8GB RAM, SSD 512GB, 15.6 Full HD 144Hz IPS, Windows 11, Preto - AN515-57-740K', weight: 2300, width: 363.4, height: 24.35, depth: 255, category: category_1, create_by: admir)

item_4 = Item.create!(name: 'Monitor Gamer LG 34 LED Ultra Wide Curvo', description: 'Monitor Gamer LG 34 LED Ultra Wide Curvo, 160 Hz, QHD, 1ms, HDMI/DisplayPort, 99% sRGB, FreeSync Premium, HDR 10, VESA, Preto - 34WP65C-B', weight: 22296, width: 80, height: 35.8, depth: 9.1, category: category_1, create_by: ana)
item_5 = Item.create!(name: 'Monitor Gamer LG 34 LED Ultra Wide Curvo', description: 'Monitor Gamer LG 34 LED Ultra Wide Curvo, 160 Hz, QHD, 1ms, HDMI/DisplayPort, 99% sRGB, FreeSync Premium, HDR 10, VESA, Preto - 34WP65C-B', weight: 22296, width: 80, height: 35.8, depth: 9.1, category: category_1, create_by: ana)
item_6 = Item.create!(name: 'Monitor Gamer LG 34 LED Ultra Wide Curvo', description: 'Monitor Gamer LG 34 LED Ultra Wide Curvo, 160 Hz, QHD, 1ms, HDMI/DisplayPort, 99% sRGB, FreeSync Premium, HDR 10, VESA, Preto - 34WP65C-B', weight: 22296, width: 80, height: 35.8, depth: 9.1, category: category_1, create_by: ana)

item_7 = Item.create!(name: 'Teclado Mecânico Gamer T-Dagger Bora', description: 'Teclado Mecânico Gamer T-Dagger Bora, RGB, Switch Outemu Brown, PT - T-TGK315-BROWN.', weight: 760, width: 13.5, height: 1.3, depth: 5.2, category: category_1, create_by: ana)
item_8 = Item.create!(name: 'Teclado Mecânico Gamer T-Dagger Bora', description: 'Teclado Mecânico Gamer T-Dagger Bora, RGB, Switch Outemu Brown, PT - T-TGK315-BROWN.', weight: 760, width: 13.5, height: 1.3, depth: 5.2, category: category_1, create_by: ana)
item_9 = Item.create!(name: 'Teclado Mecânico Gamer T-Dagger Bora', description: 'Teclado Mecânico Gamer T-Dagger Bora, RGB, Switch Outemu Brown, PT - T-TGK315-BROWN.', weight: 760, width: 13.5, height: 1.3, depth: 5.2, category: category_1, create_by: ana)

item_1.photo.attach(io: File.open(Rails.root.join('spec/support/img/Notebook Gamer Acer Nitro 5.png')), filename: 'Notebook Gamer Acer Nitro 5.png', content_type: "image/png")
item_1.save!
item_2.photo.attach(io: File.open(Rails.root.join('spec/support/img/Notebook Gamer Acer Nitro 5.png')), filename: 'Notebook Gamer Acer Nitro 5.png', content_type: "image/png")
item_2.save!
item_3.photo.attach(io: File.open(Rails.root.join('spec/support/img/Notebook Gamer Acer Nitro 5.png')), filename: 'Notebook Gamer Acer Nitro 5.png', content_type: "image/png")
item_3.save!

item_4.photo.attach(io: File.open(Rails.root.join('spec/support/img/Monitor Gamer LG 34 LED Ultra Wide Curvo.jpg')), filename: 'Monitor Gamer LG 34 LED Ultra Wide Curvo.jpg', content_type: "image/jpg")
item_4.save!
item_5.photo.attach(io: File.open(Rails.root.join('spec/support/img/Monitor Gamer LG 34 LED Ultra Wide Curvo.jpg')), filename: 'Monitor Gamer LG 34 LED Ultra Wide Curvo.jpg', content_type: "image/jpg")
item_5.save!
item_6.photo.attach(io: File.open(Rails.root.join('spec/support/img/Monitor Gamer LG 34 LED Ultra Wide Curvo.jpg')), filename: 'Monitor Gamer LG 34 LED Ultra Wide Curvo.jpg', content_type: "image/jpg")
item_6.save!

item_7.photo.attach(io: File.open(Rails.root.join('spec/support/img/Teclado Mecânico Gamer T-Dagger Bora.jpg')), filename: 'Teclado Mecânico Gamer T-Dagger Bora.jpg', content_type: "image/jpg")
item_7.save!
item_8.photo.attach(io: File.open(Rails.root.join('spec/support/img/Teclado Mecânico Gamer T-Dagger Bora.jpg')), filename: 'Teclado Mecânico Gamer T-Dagger Bora.jpg', content_type: "image/jpg")
item_8.save!
item_9.photo.attach(io: File.open(Rails.root.join('spec/support/img/Teclado Mecânico Gamer T-Dagger Bora.jpg')), filename: 'Teclado Mecânico Gamer T-Dagger Bora.jpg', content_type: "image/jpg")
item_9.save!

#Lotes
batch_1 = Batch.create!(code: 'AcSx*1-mL', start_at: DateTime.now.next_day(10), end_at: DateTime.now.next_day(30), minimum_bid: 100, minimum_bid_difference: 10, create_by: admir)
item_1.batch_id = batch_1
item_1.unavailable!
item_6.batch_id = batch_1
item_6.unavailable!
item_8.batch_id = batch_1
item_8.unavailable!

batch_2 = Batch.new(code: 'AcD+1*?Lg', start_at: DateTime.now, end_at: DateTime.now.next_day(20), minimum_bid: 150, minimum_bid_difference: 30, create_by: ana)
batch_2.save(validate: false)
item_3.batch_id = batch_2
item_3.unavailable!
item_5.batch_id = batch_2
item_5.unavailable!
item_9.batch_id = batch_2
item_9.unavailable!
batch_2.approved_by = admir
batch_2.approved!


batch_3 = Batch.new(code: 'BxF-2!?nJ', start_at: DateTime.now.prev_month, end_at: DateTime.now.prev_day(20), minimum_bid: 200, minimum_bid_difference: 50, create_by: admir)
batch_3.save(validate: false)
item_2.batch_id = batch_3
item_2.unavailable!
item_4.batch_id = batch_3
item_4.unavailable!
item_7.batch_id = batch_3
item_7.unavailable!
batch_3.approved_by = ana
batch_3.approved!

Bid.create!(batch: batch_3, user: leandro, amount: 210)
Bid.create!(batch: batch_3, user: joao, amount: 270)
Bid.create!(batch: batch_3, user: leandro, amount: 350)
Bid.create!(batch: batch_3, user: joao, amount: 420)

batch_3.winner = joao
batch_3.items.each(&:sealed!)
batch_3.finished!




