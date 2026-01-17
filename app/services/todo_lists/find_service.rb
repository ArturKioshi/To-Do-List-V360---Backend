module TodoLists
  class FindService < ApplicationService
    def initialize(id)
      @id = id
    end

    def call
      list = TodoList.find(@id)
      OpenStruct.new(success?: true, list: list)
    rescue ActiveRecord::RecordNotFound
      OpenStruct.new(success?: false, error: "Todo List not found", status: :not_found)
    end
  end
end