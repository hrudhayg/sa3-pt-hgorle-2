# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Routes follow resource naming' do
  context 'when routing' do
    specify 'Books index' do
      expect(get: books_path).to route_to 'books#index'
    end

    specify 'Books show' do
      expect(get: book_path(1)).to route_to controller: 'books', action: 'show', id: '1'
    end
  end

  context 'when creating path helpers' do
    specify 'books_path' do
      expect(books_path).to eq '/books'
    end

    specify 'book_path' do
      expect(book_path(1)).to eq '/books/1'
    end
  end
end
