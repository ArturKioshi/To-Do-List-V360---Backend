module TodoItems
  class DestroyService < ApplicationService
    def initialize(id)
      @id = id
    end

    def call
      find_result = TodoItems::FindService.call(@id)
      return find_result unless find_result.success?

      item = find_result.item
      
      if item.destroy
        OpenStruct.new(success?: true)
      else
        OpenStruct.new(
          success?: false, 
          errors: "It was not possible to delete the item", 
          status: :unprocessable_entity
        )
      end
    end
  end
end