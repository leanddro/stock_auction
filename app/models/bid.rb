class Bid < ApplicationRecord
  belongs_to :batch
  belongs_to :user
end
