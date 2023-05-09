require 'rails_helper'

describe "Usuário regular se registra no sistema" do
  it "com sucesso" do
    visit root_path
    within 'nav' do
      click_on 'Cadastra-se'
    end

    within 'form' do
      fill_in 'Nome', with: 'Leandro Gomes'
      fill_in 'CPF', with: "390.052.630-32"
      fill_in 'E-mail', with: 'leandro@email.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirme sua senha', with: '123456'

      click_on 'Cadastra-se'
    end

    within 'nav' do
      expect(page).to have_content 'Leandro Gomes'
      expect(page).to have_link 'Sair'
    end
  end

  it "valida necessário" do
    visit root_path
    within 'nav' do
      click_on 'Cadastra-se'
    end

    within 'form' do
      fill_in 'Nome', with: ''
      fill_in 'CPF', with: ''
      fill_in 'E-mail', with: 'leandro@email.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirme sua senha', with: '123456'

      click_on 'Cadastra-se'
    end

    within 'nav' do
      expect(page).to have_link 'Cadastra-se'
    end

    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'CPF não pode ficar em branco'
  end

end
