module TodoItems
  class CreateService < ApplicationService
    def initialize(todo_list_id, params)
      @todo_list_id = todo_list_id
      @params = params
    end

    def call
      find_list = TodoLists::FindService.call(@todo_list_id)
      
      unless find_list.success?
        return OpenStruct.new(
          success?: false, 
          errors: [find_list.error], 
          status: :not_found)
      end

      item = find_list.list.todo_items.build(@params)

      if item.save
        OpenStruct.new(
          success?: true, 
          item: item, 
          errors: nil)
      else
        OpenStruct.new(
          success?: false, 
          errors: item.errors.full_messages, 
          status: :unprocessable_entity)
      end
    end
  end
end