require 'rails_helper'

RSpec.describe Batch, type: :model do
  describe '#code' do
    it 'is required' do
      batch = Batch.new
      result = batch.valid?

      expect(result).to be false
      expect(batch.errors[:code]).to include 'não pode ficar em branco'
    end

    it 'is format match' do
      batch = Batch.new(code: '5as1')
      result = batch.valid?

      expect(result).to be false
      expect(batch.errors[:code]).to include 'no formato incorreto'
    end
  end

  describe '#start_at' do
    it 'is required' do
      batch = Batch.new
      result = batch.valid?

      expect(result).to be false
      expect(batch.errors[:start_at]).to include 'não pode ficar em branco'
    end

    it 'is greater than today' do
      batch = Batch.new(start_at: DateTime.now.prev_day(2))
      result = batch.valid?

      expect(result).to be false
      expect(batch.errors[:start_at]).to include 'não pode ser menor que a data atual'
    end
  end

  describe '#end_at' do
    it 'is required' do
      batch = Batch.new
      result = batch.valid?

      expect(result).to be false
      expect(batch.errors[:end_at]).to include 'não pode ficar em branco'
    end

    it 'is greater than start at' do
      batch = Batch.new(start_at: DateTime.now.prev_day(2), end_at: DateTime.now.prev_day(3))
      result = batch.valid?

      expect(result).to be false
      expect(batch.errors[:end_at]).to include 'não pode ser menor que a data de início'
    end
  end

  describe '#minimum_bid' do
    it 'is required' do
      batch = Batch.new
      result = batch.valid?

      expect(result).to be false
      expect(batch.errors[:minimum_bid]).to include 'não pode ficar em branco'
    end

    it 'is greater than 0' do
      batch = Batch.new(minimum_bid: 0)
      result = batch.valid?

      expect(result).to be false
      expect(batch.errors[:minimum_bid]).to include 'deve ser maior que 0'
    end
  end

  describe '#minimum_bid_difference' do
    it 'is required' do
      batch = Batch.new
      result = batch.valid?

      expect(result).to be false
      expect(batch.errors[:minimum_bid_difference]).to include 'não pode ficar em branco'
    end

    it 'is greater than 0' do
      batch = Batch.new(minimum_bid_difference: 0)
      result = batch.valid?

      expect(result).to be false
      expect(batch.errors[:minimum_bid_difference]).to include 'deve ser maior que 0'
    end
  end

  describe '#status' do
    it 'start in pending' do
      batch = Batch.new
      expect(batch.status).to eq 'pending'
    end
  end
end
