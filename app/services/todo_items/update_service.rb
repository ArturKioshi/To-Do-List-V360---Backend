module TodoItems
  class UpdateService < ApplicationService
    def initialize(id, params)
      @id = id
      @params = params
    end

    def call
      find_result = TodoItems::FindService.call(@id)
      return find_result unless find_result.success?

      item = find_result.item

      if item.update(@params)
        OpenStruct.new(success?: true, item: item)
      else
        OpenStruct.new(
          success?: false, 
          item: nil, 
          errors: item.errors.full_messages, 
          status: :unprocessable_entity
        )
      end
    end
  end
end