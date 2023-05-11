require 'rails_helper'

describe 'Usuário regular não tem acesso as paginas administrativas' do
  context 'categoria' do
    it 'listam' do
      user = User.create!(name: 'Leandro', cpf: '713.289.120-00', email: 'leandro@email.com', password: 'password')

      login_as user
      visit categories_path

      expect(page).to have_content 'Você não pode executar essa ação!'
    end

    it 'cadastro' do
      user = User.create!(name: 'Leandro', cpf: '713.289.120-00', email: 'leandro@email.com', password: 'password')

      login_as user
      visit new_category_path

      expect(page).to have_content 'Você não pode executar essa ação!'
    end

    it 'detalhes' do
      user = User.create!(name: 'Leandro', cpf: '713.289.120-00', email: 'leandro@email.com', password: 'password')
      category = Category.create!(name: 'Eletrônico', description: 'Incididunt officia occaecat consequat aliquip pariatur aute culpa.')

      login_as user
      visit category_path(category.id)

      expect(page).to have_content 'Você não pode executar essa ação!'
    end
  end

  context 'item' do
    it 'listam' do
      user = User.create!(name: 'Leandro', cpf: '713.289.120-00', email: 'leandro@email.com', password: 'password')

      login_as user
      visit items_path

      expect(page).to have_content 'Você não pode executar essa ação!'
    end

    it 'cadastro' do
      user = User.create!(name: 'Leandro', cpf: '713.289.120-00', email: 'leandro@email.com', password: 'password')

      login_as user
      visit new_item_path

      expect(page).to have_content 'Você não pode executar essa ação!'
    end

    it 'detalhes' do
      user = User.create!(name: 'Leandro', cpf: '713.289.120-00', email: 'leandro@email.com', password: 'password')
      admin = User.create!(name: 'Admir', cpf: '054.732.630-03', email: 'admir@leilaodogalpao.com.br', password: 'password')
      category = Category.create!(name: 'Eletrônico', description: 'Incididunt officia occaecat consequat aliquip pariatur aute culpa.')
      item = Item.create!(name: 'Notebook Gamer Acer Nitro 5', description: 'Intel Core i7-11800H, GeForce GTX 1650, 8GB RAM, SSD 512GB, 15.6 Full HD 144Hz IPS, Windows 11, Preto - AN515-57-740K', weight: 2300, width: 363.4, height: 24.35, depth: 255, category: category, create_by: admin)

      login_as user
      visit item_path(item.id)

      expect(page).to have_content 'Você não pode executar essa ação!'
    end
  end
end
