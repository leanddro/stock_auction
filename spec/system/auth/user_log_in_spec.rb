require 'rails_helper'

describe 'Usuário faze log_in no sistema' do
  it 'com sucesso' do
    User.create!(name: 'Leandro', cpf: '713.289.120-00', email: 'leandro@email.com', password: 'password')


    visit root_path
    within 'nav' do
      click_on 'Entrar'
    end

    within 'form' do
      fill_in 'E-mail', with: 'leandro@email.com'
      fill_in 'Senha', with: 'password'

      click_on 'Entrar'
    end

    expect(page).to have_content 'Leandro'
  end
