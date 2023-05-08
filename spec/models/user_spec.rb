require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'role' do
    it 'seta role padrão' do
      user = User.new

      expect(user.role).to eq 'regular'
    end

    it 'seta admin quando domínio correto' do
      user = User.new(email: "user@leilaodogalpao.com.br")

      expect(user.role).to eq 'admin'
    end
  end


end
