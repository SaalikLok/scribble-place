class Scribble < ApplicationRecord
  validates :content, presence: true, length: { maximum: 10000 }

  belongs_to :user
end
