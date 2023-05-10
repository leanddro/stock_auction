class Category < ApplicationRecord
  after_initialize :set_default_active, :if => :new_record?

  validates :name, :description, presence: true

  private
  def set_default_active
    self.active = true
  end
end
