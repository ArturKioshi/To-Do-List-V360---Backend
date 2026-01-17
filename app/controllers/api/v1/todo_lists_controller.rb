module Api
  module V1
    class TodoListsController < ApplicationController
      # GET /api/v1/todo_lists
      def index
        result = TodoLists::IndexService.call(params)
        render json: result.lists
      end

      # GET /api/v1/todo_lists/:id
      def show
        result = TodoLists::FindService.call(params[:id])

        if result.success?
          render json: result.list
        else
          render json: { error: result.error }, status: result.status
        end
      end

      # POST /api/v1/todo_lists
      def create
        result = TodoLists::CreateService.call(list_params)

        if result.success?
          render json: result.list, status: :created
        else
          render json: { errors: result.error }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/todo_lists/:id
      def update
        result = TodoLists::UpdateService.call(params[:id], list_params)

        if result.success?
          render json: result.list
        else
          render json: { errors: result.error }, status: result.status
        end
      end

      # DELETE /api/v1/todo_lists/:id
      def destroy
        result = TodoLists::DestroyService.call(params[:id])

        if result.success?
          head :no_content
        else
          render json: { errors: result.error }, status: result.status
        end
      end

      private

      def list_params
        params.require(:todo_list).permit(:title, :description)
      end
    end
  end
end