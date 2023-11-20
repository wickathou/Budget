class Entry < ApplicationRecord
  belongs_to :user
  has_many_and_belongs_to_many :categories
end
