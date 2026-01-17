module TodoLists
  class DestroyService < ApplicationService
    def initialize(id)
      @id = id
    end

    def call
      find_result = TodoLists::FindService.call(@id)
      return find_result unless find_result.success?

      list = find_result.list

      if list.destroy
        OpenStruct.new(success?: true)
      else
        OpenStruct.new(
          success?: false, 
          error: "It was not possible to delete the list", 
          status: :unprocessable_entity
        )
      end
    end
  end
end