require 'rails_helper'

describe 'Usuário admin na tela de detalhe da categoria e muda o status de ativo' do
  it 'com sucesso alterando para inativo' do
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
    click_on 'Eletrônico'

    click_on 'Desativar'

    expect(Category.last.active).to eq false
  end

  it 'com sucesso alterando para ativo' do
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
    click_on 'Eletrônico'

    click_on 'Desativar'
    click_on 'Ativar'

    expect(Category.last.active).to eq true
  end


end

