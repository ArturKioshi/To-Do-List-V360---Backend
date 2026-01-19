require 'rails_helper'

RSpec.describe 'TodoLists API', type: :request do
  def json_parse
    JSON.parse(response.body)
  end

  # Test index: GET /api/v1/todo_lists
  describe 'GET /api/v1/todo_lists' do
    let!(:list1) { TodoList.create(title: "Test List 1") }
    let!(:list2) { TodoList.create(title: "Test List 2") }

    it 'returns all todo lists' do
      get '/api/v1/todo_lists'
      
      expect(response).to have_http_status(:ok)
      expect(json_parse.length).to eq(2
      )
      titles = json_parse.map { |list| list['title'] }
      expect(titles).to include("Test List 1", "Test List 2")
    end
  end

  # Test create: POST /api/v1/todo_lists
  describe 'POST /api/v1/todo_lists' do
    context 'with valid parameters' do
      let(:valid_params) { { todo_list: { title: "New List" } } }

      it 'creates a new todo list' do
        post '/api/v1/todo_lists', params: valid_params

        expect(response).to have_http_status(:created)
        expect(json_parse['title']).to eq("New List")
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { todo_list: { title: "" } } }

      it 'does not create a new todo list' do
        post '/api/v1/todo_lists', params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  #Test show: GET /api/v1/todo_lists/:id
  describe 'GET /api/v1/todo_lists/:id' do
    let!(:list) { TodoList.create(title: "Test List") }

    it 'returns the specified todo list' do
      get "/api/v1/todo_lists/#{list.id}"

      expect(response).to have_http_status(:ok)
      expect(json_parse['title']).to eq("Test List")
    end
  end

  # Test delete: DELETE /api/v1/todo_lists/:id
  describe 'DELETE /api/v1/todo_lists/:id' do
    let!(:list) { TodoList.create(title: "Test List") }

    it 'deletes the specified todo list' do
      delete "/api/v1/todo_lists/#{list.id}"

      expect(response).to have_http_status(:no_content)
      expect(TodoList.find_by(id: list.id)).to be_nil
    end
  end

  #Test update: PUT /api/v1/todo_lists/:id
  describe 'PUT /api/v1/todo_lists/:id' do
    let!(:list) { TodoList.create(title: "Old Title") }
    let(:update_params) { { todo_list: { title: "Updated Title" } } }

    it 'updates the specified todo list' do
      put "/api/v1/todo_lists/#{list.id}", params: update_params

      expect(response).to have_http_status(:ok)
      expect(json_parse['title']).to eq("Updated Title")
    end
  end
end