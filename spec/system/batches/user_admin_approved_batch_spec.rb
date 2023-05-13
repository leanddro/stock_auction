require 'rails_helper'

describe 'Usuário admin aprova lote' do
  it 'quando ele que criou o lote' do
    user = User.create!(name: 'Admir', cpf: '054.732.630-03', email: 'admir@leilaodogalpao.com.br', password: 'password')
    batch = Batch.create!(code: 'AcSx*1-mL', start_at: DateTime.now.next_day(10), end_at: DateTime.now.next_day(20), minimum_bid: 100, minimum_bid_difference: 10, create_by: user)

    login_as user
    visit root_path

    click_on 'Lotes'

    within '#pending' do
      find("a[href='/batches/#{batch.id}']").click
    end

    expect(page).not_to have_link 'Aprovar'
    expect(page).not_to have_link 'Finalizar'
    expect(page).to have_link 'Cancelar'
  end

  it 'quando outro usuário criou o lote' do
    admir = User.create!(name: 'Admir', cpf: '054.732.630-03', email: 'admir@leilaodogalpao.com.br', password: 'password')
    leo = User.create!(name: 'Leo', cpf: '718.167.630-04', email: 'leo@leilaodogalpao.com.br', password: 'password')
    batch = Batch.create!(code: 'AcSx*1-mL', start_at: DateTime.now.next_day(10), end_at: DateTime.now.next_day(20), minimum_bid: 100, minimum_bid_difference: 10, create_by: admir)

    login_as leo
    visit root_path

    click_on 'Lotes'

    within '#pending' do
      find("a[href='/batches/#{batch.id}']").click
    end

    click_on 'Aprovar'

    expect(page).to have_content 'Lote aprovado com sucesso'
  end
end
