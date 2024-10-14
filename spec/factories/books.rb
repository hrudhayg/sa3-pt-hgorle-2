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
FactoryBot.define do
  factory :book do
    title { 'Book' }
  end
end
