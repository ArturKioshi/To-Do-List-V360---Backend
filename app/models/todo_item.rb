class TodoItem < ApplicationRecord
  belongs_to :todo_list

  validates :title, presence: true
  validates :priority, inclusion: { 
    in: 1..3, 
    message: "must be between 1 and 3"
  }
  validates :priority, numericality: { only_integer: true }

  scope :ordered, -> { order(priority: :desc, due_date: :asc) }
end
