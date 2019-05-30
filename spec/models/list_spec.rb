require 'rails_helper'

RSpec.describe List, type: :model do
 let(:name) { RandomData.random_sentence }
 let(:description) { RandomData.random_sentence }
 let(:public) { true }
 let(:list) { List.create!(name: name, description: description, user: user) }
 let(:user) {User.create!(name: "Misty Gish", email: "mistygish@mail.com", password: "password")}

   it {is_expected.to belong_to (:user)}
   it { is_expected.to validate_presence_of(:user)}
   it {is_expected.to have_many(:items)}
   describe "attributes" do
     it "has name, description, and public attributes" do
       expect(list).to have_attributes(name: name, description: description, public: public, user: user)
     end

     it "is public by default" do
       expect(list.public).to be(true)
     end
   end
 end
