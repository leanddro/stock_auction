class Item < ApplicationRecord
  belongs_to :create_by, class_name: "User", foreign_key: "create_by_id"
  belongs_to :category

  before_validation :generate_code, on: :create
  validates :name, :description, :weight, :width, :height, :depth, presence: true
  validates :code, uniqueness: true


  def dimension
    "#{self.width}(L) x #{self.depth}(P) x #{self.height}(A) cm"
  end

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end
end
