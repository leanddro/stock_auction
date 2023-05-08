require 'rails_helper'

describe "Usuário admin se registra no sistema" do
  it "com sucesso" do
    visit root_path
    within 'nav' do
      click_on 'Cadastra-se'
    end

    within 'form' do
      fill_in 'Nome', with: 'Leandro Gomes'
      fill_in 'CPF', with: "617.732.100-33"
      fill_in 'E-mail', with: 'leandro@leilaodogalpao.com.br'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirme sua senha', with: '123456'

      click_on 'Cadastra-se'
    end

    within 'nav' do
      expect(page).to have_content 'Leandro Gomes'
      expect(page).to have_link 'Sair'
    end

    expect(User.last.role).to eq 'admin'
  end
end
