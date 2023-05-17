class Batch < ApplicationRecord
  after_initialize :set_default_status, if: :new_record?
  belongs_to :create_by, class_name: 'User', foreign_key: 'create_by_id'
  belongs_to :approved_by, class_name: 'User', foreign_key: 'approved_by_id', optional: true
  belongs_to :winner, class_name: 'User', foreign_key: 'winner_id', optional: true
  has_many :items
  has_many :bids

  validates :code, :start_at, :end_at, :minimum_bid, :minimum_bid_difference, presence: true
  validates :code, uniqueness: true, format: { with: /\A[a-zA-Z]{3}[a-zA-Z0-9\-!@#$%^&*_+|~=`{}\\\\:"'<>?,.]{6}\z/ }
  validates :minimum_bid, :minimum_bid_difference, comparison: { greater_than: 0 }
  validates :start_at, comparison: { greater_than: DateTime.now, message: :smaller_today }, on: :create
  validates :end_at, comparison: { greater_than: :start_at, message: :smaller_start }, on: :create

  enum status: { pending: 1, approved: 3, finished: 5, canceled: 7 }

  private

  def set_default_status
    self.status = :pending
  end
end
