module TodoItems
  class IndexService < ApplicationService
    def initialize(todo_list_id = nil)
      @todo_list_id = todo_list_id
    end

    def call
      if @todo_list_id.present?
        find_list = TodoLists::FindService.call(@todo_list_id)
        
        unless find_list.success?
          return OpenStruct.new(
            success?: false, 
            errors: [find_list.error], 
            status: :not_found)
        end

        items = find_list.list.todo_items.ordered

      else
        items = TodoItem.ordered
      end

      OpenStruct.new(success?: true, items: items)
    end
  end
end