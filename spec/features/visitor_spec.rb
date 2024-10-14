# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Visitor Features' do
  let!(:book_one) do
    create(:book, title: 'Book One', author: 'Author One', year: 2000, publisher: 'Publisher One')
  end
  let!(:book_two) do
    create(:book, title: 'Book Two', author: 'Author Two', year: 2001, publisher: 'Publisher Two')
  end

  feature 'Browse Books' do
    scenario 'Viewing the book index page content' do
      visit books_path

      expect(page).to have_css('h1', text: 'Book List')
      within('table') do
        within('thead') do
          within('tr') do
            expect(page).to have_css('th', text: 'Title')
            expect(page).to have_css('th', text: 'Author')
            expect(page).to have_css('th', exact_text: '', count: 1)
          end
        end
        within('tbody') do
          expect(page).to have_css('tr', count: 2)

          within('tr:nth-child(1)') do
            expect(page).to have_css('td', text: book_one.title)
            expect(page).to have_css('td', text: book_one.author)
            expect(page).to have_link('Show')
          end

          within('tr:nth-child(2)') do
            expect(page).to have_css('td', text: book_two.title)
            expect(page).to have_css('td', text: book_two.author)
            expect(page).to have_link('Show')
          end
        end
      end
    end

    scenario 'Redirecting from the root page to the books page' do
      visit root_path

      expect(page).to have_current_path(books_path, ignore_query: true)
    end
  end

  feature 'View Book Details' do
    scenario 'Viewing a book show page content' do
      visit book_path(book_one)

      expect(page).to have_css('h1', text: book_one.title)
      expect(page).to have_css('ul', count: 1)
      expect(page).to have_css('ul li', count: 3)
      expect(page).to have_css('li', text: "Author: #{book_one.author}")
      expect(page).to have_css('li', text: "Year Published: #{book_one.year}")
      expect(page).to have_css('li', text: "Publisher: #{book_one.publisher}")
      expect(page).to have_link('Back to Book List')
    end

    scenario 'Navigating to a book show page from the index page' do
      visit books_path

      click_on 'Show', match: :first

      expect(page).to have_current_path(book_path(book_one), ignore_query: true)
    end

    scenario 'Navigating back to the book index page from the show page' do
      visit book_path(book_one)
      click_on 'Back to Book List'

      expect(page).to have_current_path(books_path, ignore_query: true)
    end
  end
end
