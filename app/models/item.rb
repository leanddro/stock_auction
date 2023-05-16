class Item < ApplicationRecord
  after_initialize :set_default_status, :if => :new_record?
  belongs_to :create_by, class_name: "User", foreign_key: "create_by_id"
  belongs_to :category
  belongs_to :batch, optional: true
  has_one_attached :photo
  has_many :batch_items
  has_many :batches, through: :batch_items

  before_validation :generate_code, on: :create
  validates :name, :description, :weight, :width, :height, :depth, presence: true
  validates :code, uniqueness: true

  enum status: {available: 1, unavailable: 5,  sealed: 9}

  def dimension
    "#{self.width}(L) x #{self.depth}(P) x #{self.height}(A) cm"
  end

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end

  def set_default_status
    self.status = :available
  end
end
