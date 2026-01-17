module TodoItems
  class FindService < ApplicationService
    def initialize(id)
      @id = id
    end

    def call
      item = TodoItem.find_by(id: @id)

      if item
        OpenStruct.new(success?: true, item: item, errors: nil)
      else
        OpenStruct.new(
          success?: false, 
          errors: "Item not found", 
          status: :not_found
        )
      end
    end
  end
end