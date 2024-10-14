# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id         :bigint           not null, primary key
#  author     :string
#  publisher  :string
#  title      :string
#  year       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Book do
  it 'has the correct non-string column types' do
    columns = ActiveRecord::Base.connection.columns(:books)

    expect(columns.find { |c| c.name == 'year' }.sql_type).to eq 'integer'
  end

  it 'has seeds' do
    load Rails.root.join('db/seeds.rb').to_s

    expect(described_class.count).to eq 5
    expect(described_class.order(:title).pluck(:title, :author, :year, :publisher))
      .to eq [['Death on the Nile', 'Agatha Christie', 1937, 'Collins Crime Club'],
              ['Fahrenheit 451', 'Ray Bradbury', 1953, 'Ballantine Books'],
              ['Jaws', 'Peter Benchley', 1974, 'Doubleday'],
              ['Murder on the Orient Express', 'Agatha Christie', 1934, 'Collins Crime Club'],
              ['Slaughterhouse-Five', 'Kurt Vonnegut', 1969, 'Delacorte']]
  end
end
