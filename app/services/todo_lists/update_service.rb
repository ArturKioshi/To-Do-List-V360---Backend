module TodoLists
  class UpdateService < ApplicationService
    def initialize(id, params)
      @id = id
      @params = params
    end

    def call
      find_result = TodoLists::FindService.call(@id)
      return find_result unless find_result.success?

      list = find_result.list

      if list.update(@params)
        OpenStruct.new(success?: true, list: list)
      else
        OpenStruct.new(success?: false, error: list.errors.full_messages, status: :unprocessable_entity)
      end
    end
  end
end