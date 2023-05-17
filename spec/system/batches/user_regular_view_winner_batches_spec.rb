require 'rails_helper'

describe 'Usuário regular vê vencedores de lotes finalizados' do
  it 'a partir da home page' do
    admin = User.create!(name: 'Leo', cpf: '354.410.250-18', email: 'leo@leilaodogalpao.com.br', password: 'password')
    leandro = User.create!(name: 'Leandro', cpf: '713.289.120-00', email: 'leandro@email.com', password: 'password')
    ana = User.create!(name: 'Ana', cpf: '498.265.430-12', email: 'ana@email.com', password: 'password')
    batch = nil
    other_batch = nil

    travel_to DateTime.now.prev_month do
      batch = Batch.new(code: 'AcSx*1-mL', start_at: DateTime.now.next_day, end_at: DateTime.now.next_day(10), minimum_bid: 100, minimum_bid_difference: 10, create_by: admin)
      batch.approved!

      other_batch = Batch.new(code: 'AcFx*5-mL', start_at: DateTime.now.next_day(10), end_at: DateTime.now.next_day(20), minimum_bid: 150, minimum_bid_difference: 20, create_by: admin)
      other_batch.approved!
    end

    travel_to DateTime.now.prev_day(10) do
      Bid.create!(batch:, user: leandro, amount: 100)
      Bid.create!(batch:, user: ana, amount: 200)
      Bid.create!(batch:, user: leandro, amount: 250)

      Bid.create!(batch: other_batch, user: ana, amount: 150)
      Bid.create!(batch: other_batch, user: leandro, amount: 250)
      Bid.create!(batch: other_batch, user: ana, amount: 300)
    end

    batch.winner = leandro
    batch.finished!
    other_batch.winner = ana
    other_batch.finished!


    login_as leandro
    visit root_path

    within 'nav' do
      click_on 'Ganhadores'
    end

    expect(page).to have_content 'Código: AcSx*1-mL'
    expect(page).to have_content 'Ganhador: LEANDRO'
    expect(page).to have_content 'Lance ganhador: R$ 250,00'

    expect(page).to have_content 'Código: AcFx*5-mL'
    expect(page).to have_content 'Ganhador: ANA'
    expect(page).to have_content 'Lance ganhador: R$ 300,00'
  end

  it 'a partir da perfil do usuário' do
    admin = User.create!(name: 'Leo', cpf: '354.410.250-18', email: 'leo@leilaodogalpao.com.br', password: 'password')
    leandro = User.create!(name: 'Leandro', cpf: '713.289.120-00', email: 'leandro@email.com', password: 'password')
    ana = User.create!(name: 'Ana', cpf: '498.265.430-12', email: 'ana@email.com', password: 'password')
    batch = nil
    other_batch = nil

    travel_to DateTime.now.prev_month do
      batch = Batch.new(code: 'AcSx*1-mL', start_at: DateTime.now.next_day, end_at: DateTime.now.next_day(10), minimum_bid: 100, minimum_bid_difference: 10, create_by: admin)
      batch.approved!

      other_batch = Batch.new(code: 'AcFx*5-mL', start_at: DateTime.now.next_day(10), end_at: DateTime.now.next_day(20), minimum_bid: 150, minimum_bid_difference: 20, create_by: admin)
      other_batch.approved!
    end

    travel_to DateTime.now.prev_day(10) do
      Bid.create!(batch:, user: leandro, amount: 100)
      Bid.create!(batch:, user: ana, amount: 200)
      Bid.create!(batch:, user: leandro, amount: 250)

      Bid.create!(batch: other_batch, user: ana, amount: 150)
      Bid.create!(batch: other_batch, user: leandro, amount: 250)
      Bid.create!(batch: other_batch, user: ana, amount: 300)
    end

    batch.winner = leandro
    batch.finished!
    other_batch.winner = ana
    other_batch.finished!


    login_as leandro
    visit root_path

    within 'nav' do
      click_on 'Leandro'
    end

    expect(page).to have_content 'Código: AcSx*1-mL'
    expect(page).to have_content 'Ganhador: LEANDRO'
    expect(page).to have_content 'Lance ganhador: R$ 250,00'
  end
end
