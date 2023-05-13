require 'rails_helper'

describe 'Usuário ver seu perfil' do
  it 'usuário não logado tenta acessar' do
    visit user_profile_path

    expect(page).to have_content 'Para continuar, faça login ou registre-se'
  end

  it 'usuário regular acessa' do
    user = User.create!(name: 'Leandro', cpf: '220.177.900-79', email: 'leandro@email.com', password: 'password')

    login_as user
    visit user_profile_path

    expect(page).to have_content 'Nome: Leandro'
    expect(page).to have_content 'E-mail: leandro@email.com'
    expect(page).to have_content 'Função: Usuário'
  end

  it 'usuário admin acessa' do
    user = User.create!(name: 'Leandro', cpf: '220.177.900-79', email: 'leandro@leilaodogalpao.com.br', password: 'password')
    admir = User.create!(name: 'Admir', cpf: '095.151.800-31', email: 'admir@leilaodogalpao.com.br', password: 'password')
    batch = Batch.create!(code: 'AcSx*1-mL', start_at: DateTime.now.next_day(10), end_at: DateTime.now.next_day(20), minimum_bid: 100, minimum_bid_difference: 10, create_by: user)
    login_as admir
    visit user_profile_path

    expect(page).to have_content 'Nome: Admir'
    expect(page).to have_content 'E-mail: admir@leilaodogalpao.com.br'
    expect(page).to have_content 'Função: Administrador'
    expect(page).to have_content 'Código: AcSx*1-mL'
  end


end

