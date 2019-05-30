require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:name) { RandomData.random_word }
  let(:description) { RandomData.random_sentence }
  let(:title) { RandomData.random_word }
  let(:amount) { RandomData.random_number }
  let(:completed) { false }

   let(:list) { List.create!(name: name, description: description) }

   let(:item) { list.items.create!(title: title, amount: amount) }

   it { is_expected.to belong_to(:list) }
end
