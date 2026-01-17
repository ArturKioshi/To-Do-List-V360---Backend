module Api
  module V1
    class TodoItemsController < ApplicationController

      #GET /api/v1/todo_items/(All todo items)
      #GET /api/v1/todo_lists/:todo_list_id/todo_items (Specific todo list items)
      def index
        result = TodoItems::IndexService.call(params[:todo_list_id])

        if result.success?
          render json: result.items, status: :ok
        else
          render json: { errors: result.errors }, status: result.status || :unprocessable_entity
        end
      end

      #POST /api/v1/todo_lists/:todo_list_id/todo_items
      def create
        result = TodoItems::CreateService.call(params[:todo_list_id], item_params)

        if result.success?
          render json: result.item, status: :created
        else
          render json: { errors: result.errors }, status: result.status || :unprocessable_entity
        end
      end


      # GET /api/v1/todo_items/:id
      def show
        result = TodoItems::FindService.call(params[:id])

        if result.success?
          render json: result.item, status: :ok
        else
          render json: { errors: [result.errors] }, status: result.status
        end
      end

      # PATCH/PUT /api/v1/todo_items/:id
      def update
        result = TodoItems::UpdateService.call(params[:id], item_params)

        if result.success?
          render json: result.item, status: :ok
        else
          render json: { errors: result.errors || [result.errors] }, status: result.status || :unprocessable_entity
        end
      end

      # DELETE /api/v1/todo_items/:id
      def destroy
        result = TodoItems::DestroyService.call(params[:id])

        if result.success?
          head :no_content 
        else
          render json: { errors: result.errors }, status: result.status || :unprocessable_entity
        end
      end

      private

      def item_params
        params.require(:todo_item).permit(
          :title, 
          :content, 
          :completed, 
          :due_date, 
          :priority
        )
      end
    end
  end
end