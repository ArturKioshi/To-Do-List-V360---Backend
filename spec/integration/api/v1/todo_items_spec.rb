require 'rails_helper'

RSpec.describe 'TodoItems API', type: :request do
  def json_parse
    JSON.parse(response.body)
  end

  let!(:todo_list) { TodoList.create(title: "Todo List") }

  # Test for GET /api/v1/todo_items
  describe 'GET /api/v1/todo_items' do
    let!(:item1) { TodoItem.create(title: "Item 1", priority: 1, todo_list: todo_list) }
    let!(:item2) { TodoItem.create(title: "Item 2", priority: 2, todo_list: todo_list) }

    it 'returns all todo items' do
      get '/api/v1/todo_items'
      expect(response).to have_http_status(:ok)
      expect(json_parse.size).to eq(2)

      titles = json_parse.map { |item| item['title'] }
      expect(titles).to include("Item 1", "Item 2")
    end
  end

  # Test for POST /api/v1/todo_lists/:todo_list_id/todo_items
  describe 'POST /api/v1/todo_lists/:todo_list_id/todo_items' do
    context 'with valid parameters' do
      let(:valid_attributes) do
          {
            todo_item: {
              title: "New Item",
              priority: 1,
              content: "This is a new todo item"
            }
          }
        end

        it 'creates a new todo item' do
          post "/api/v1/todo_lists/#{todo_list.id}/todo_items", params: valid_attributes
          
          expect(response).to have_http_status(:created)
          expect(json_parse['title']).to eq("New Item")
          expect(json_parse['content']).to eq("This is a new todo item")
        end
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          todo_item: {
            title: "New Item",
            priority: 5,  # Invalid priority
            content: "This is a new todo item"
          }
        }
      end

      it 'returns an unprocessable entity status' do
        post "/api/v1/todo_lists/#{todo_list.id}/todo_items", params: invalid_attributes
        
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    # Test for GET /api/v1/todo_items/:id
    describe 'GET /api/v1/todo_items/:id' do
      let!(:todo_item) { TodoItem.create(title: "Item 1", priority: 1, todo_list: todo_list) }

      it 'returns the specified todo item' do
        get "/api/v1/todo_items/#{todo_item.id}"
        
        expect(response).to have_http_status(:ok)
        expect(json_parse['title']).to eq("Item 1")
      end
    end

    # Test for #GET /api/v1/todo_lists/:todo_list_id/todo_items
    describe 'GET /api/v1/todo_lists/:todo_list_id/todo_items' do
      let!(:item1) { TodoItem.create(title: "Item 1", priority: 1, todo_list: todo_list) }
      let!(:item2) { TodoItem.create(title: "Item 2", priority: 2, todo_list: todo_list) }

      it 'returns all todo items for the specified todo list' do
        get "/api/v1/todo_lists/#{todo_list.id}/todo_items"
        
        expect(response).to have_http_status(:ok)
        expect(json_parse.size).to eq(2)

        titles = json_parse.map { |item| item['title'] }
        expect(titles).to include("Item 1", "Item 2")
      end
    end

    # Test for PATCH /api/v1/todo_items/:id
    describe 'PATCH /api/v1/todo_items/:id' do
      let!(:todo_item) { TodoItem.create(title: "Item 1", priority: 1, todo_list: todo_list) }
      let(:update_attributes) do
        {
          todo_item: {
            title: "Updated Item",
            priority: 2
          }
        }
      end

      it 'updates the specified todo item' do
        patch "/api/v1/todo_items/#{todo_item.id}", params: update_attributes
        
        expect(response).to have_http_status(:ok)
        expect(json_parse['title']).to eq("Updated Item")
        expect(json_parse['priority']).to eq(2)
      end
    end

    #Test for DELETE /api/v1/todo_items/:id
    describe 'DELETE /api/v1/todo_items/:id' do
      let!(:todo_item) { TodoItem.create(title: "Item to be deleted", priority: 1, todo_list: todo_list) }

      it 'deletes the specified todo item' do
        delete "/api/v1/todo_items/#{todo_item.id}"
        
        expect(response).to have_http_status(:no_content)
        expect(TodoItem.find_by(id: todo_item.id)).to be_nil
      end
    end
end