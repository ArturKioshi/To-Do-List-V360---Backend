module TodoLists
  class CreateService < ApplicationService
    def initialize(params)
      @params = params
    end

    def call
      list = TodoList.new(@params)

      if list.save
        OpenStruct.new(success?: true, list: list, errors: nil)
      else
        OpenStruct.new(success?: false, list: list.errors.full_messages)
      end
    end
  end
end