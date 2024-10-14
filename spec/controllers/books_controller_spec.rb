# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BooksController do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    let!(:book) { create(:book) }

    it 'returns a success response' do
      get :show, params: { id: book }
      expect(response).to be_successful
    end

    it 'renders the show template' do
      get :show, params: { id: book }
      expect(response).to render_template(:show)
    end
  end
end
