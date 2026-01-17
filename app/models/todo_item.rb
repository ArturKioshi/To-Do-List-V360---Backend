class TodoItem < ApplicationRecord
  belongs_to :todo_list

  validates :title, presence: true
  validates :priority, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :ordered, -> { order(priority: :desc, due_date: :asc) }
end
