require 'rails_helper'

describe 'Usuário admin registrar item' do
  it 'com sucesso' do
    user = User.create!(name: 'Admir', cpf: '054.732.630-03', email: 'admir@leilaodogalpao.com.br', password: 'password')
    category = Category.create!(name: 'Eletrônico', description: 'Incididunt officia occaecat consequat aliquip pariatur aute culpa.')

    login_as user
    visit root_path

    click_on 'Itens'
    click_on 'Novo'

    fill_in 'Nome', with: 'Notebook Gamer Acer Nitro 5'
    fill_in 'Descrição', with: 'Intel Core i7-11800H, GeForce GTX 1650, 8GB RAM, SSD 512GB, 15.6 Full HD 144Hz IPS, Windows 11, Preto - AN515-57-740K'
    fill_in 'Peso', with: 2300
    fill_in 'Largura', with: 363.4
    fill_in 'Altura', with: 24.35
    fill_in 'Profundidade', with: 255
    select 'Eletrônico', from: 'Categoria'

    click_on 'Cadastrar'

    expect(page).to have_content 'Notebook Gamer Acer Nitro 5'
    expect(page).to have_content 'Intel Core i7-11800H, GeForce GTX 1650, 8GB RAM, SSD 512GB, 15.6 Full HD 144Hz IPS, Windows 11, Preto - AN515-57-740K'
    expect(page).to have_content '- 363.4(L) x 255.0(P) x 24.35(A) cm'
  end

  it 'falha compos obrigatórios' do
    user = User.create!(name: 'Admir', cpf: '054.732.630-03', email: 'admir@leilaodogalpao.com.br', password: 'password')
    category = Category.create!(name: 'Eletrônico', description: 'Incididunt officia occaecat consequat aliquip pariatur aute culpa.')

    login_as user
    visit root_path

    click_on 'Itens'
    click_on 'Novo'

    fill_in 'Nome', with: 'Notebook Gamer Acer Nitro 5'
    fill_in 'Descrição', with: ''
    fill_in 'Peso', with: ''
    fill_in 'Largura', with: 363.4
    fill_in 'Altura', with: 24.35
    fill_in 'Profundidade', with: 255
    select 'Eletrônico', from: 'Categoria'

    click_on 'Cadastrar'

    expect(page).to have_content 'Não foi possível cadastrar item'
    within '.bg-yellow-100' do
      expect(page).to have_content 'Descrição não pode ficar em branco'
      expect(page).to have_content 'Peso não pode ficar em branco'
    end
  end

end

