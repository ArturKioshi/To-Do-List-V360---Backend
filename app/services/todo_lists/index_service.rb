module TodoLists
  class IndexService < ApplicationService
    def initialize(params = {})
      @params = params
    end

    def call
      lists = TodoList.all
      
      OpenStruct.new(success?: true, lists: lists)
    end
  end
end