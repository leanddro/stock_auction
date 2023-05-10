require 'rails_helper'

describe 'Usuário admin registra nova categoria' do
  it 'usuário regular sem acesso' do
    user = User.create!(name: 'Leandro', cpf: '713.289.120-00', email: 'leandro@email.com', password: 'password')

    login_as user
    visit root_path

    within 'nav' do
      expect(page).not_to have_link 'Categorias'
    end
  end

  it 'com sucesso' do
    user = User.create!(name: 'Admir', cpf: '054.732.630-03', email: 'admir@leilaodogalpao.com.br', password: 'password')

    login_as user
    visit root_path

    within 'nav' do
      click_on 'Categorias'
    end

    click_on 'Nova'

    fill_in 'Nome', with: 'Eletrônico'
    fill_in 'Descrição', with: 'São aqueles em que é possível controlar a energia elétrica por meios elétrico nos quais os elétrons têm papel fundamental'

    click_on 'Cadastrar'

    expect(page).to have_content 'Eletrônico'
  end

  it 'campos obrigatórios' do
    user = User.create!(name: 'Admir', cpf: '054.732.630-03', email: 'admir@leilaodogalpao.com.br', password: 'password')

    login_as user
    visit root_path

    within 'nav' do
      click_on 'Categorias'
    end

    click_on 'Nova'

    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''

    click_on 'Cadastrar'

    expect(page).to have_content 'Erro ao cadastrar categoria'

    within '.bg-yellow-100' do
      expect(page).to have_content 'Nome não pode ficar em branco'
      expect(page).to have_content 'Descrição não pode ficar em branco'
    end
  end
end

