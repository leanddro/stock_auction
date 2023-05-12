require 'rails_helper'

describe 'Usuário admin configura novo lote' do
  it 'Com sucesso' do
    user = User.create!(name: 'Admir', cpf: '054.732.630-03', email: 'admir@leilaodogalpao.com.br', password: 'password')
    start_at = DateTime.now.next_day(10)
    end_at = start_at.next_day(20)

    login_as user
    visit root_path

    click_on 'Lotes'
    click_on 'Novo'

    fill_in 'Código', with: 'AbC1a*35c'
    fill_in 'Data de Inicio', with: start_at
    fill_in 'Data de Fim', with: end_at
    fill_in 'Lance mínimo inicial', with: 100
    fill_in 'Diferença minima entre lances', with: 10

    click_on 'Cadastrar'

    expect(page).to have_content 'Código: AbC1a*35c'
    expect(page).to have_content "Data de inicio: #{I18n.l(start_at, format: :long)}"
    expect(page).to have_content "Data de fim: #{I18n.l(end_at, format: :long)}"
    expect(page).to have_content 'Lance mínimo inicial: R$ 100,00'
    expect(page).to have_content 'Diferença minima entre lances: R$ 10,00'

  end

  it 'campos obrigatórios' do
    user = User.create!(name: 'Admir', cpf: '054.732.630-03', email: 'admir@leilaodogalpao.com.br', password: 'password')
    start_at = DateTime.now.next_day(10)
    end_at = start_at.next_day(20)

    login_as user
    visit root_path

    click_on 'Lotes'
    click_on 'Novo'

    fill_in 'Código', with: ''
    fill_in 'Data de Inicio', with: start_at
    fill_in 'Data de Fim', with: end_at
    fill_in 'Lance mínimo inicial', with: ''
    fill_in 'Diferença minima entre lances', with: 10

    click_on 'Cadastrar'

    expect(page).to have_content 'Não foi possível cadastrar o lote'
    expect(page).to have_content 'Lance mínimo inicial não pode ficar em branco'
  end
end
