require 'rails_helper'
include SessionsHelper

RSpec.describe ListsController, type: :controller do

  let(:my_user) { User.create!(name: "Misty Gish", email: "mistygish@mail.com", password: "password")}
  let(:my_list) { List.create!(user: my_user, name: RandomData.random_word, description: RandomData.random_sentence) }

  context "signed-in user" do
    before do
      create_session(my_user)
    end

    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
    end

    it "assigns my_list to @lists" do
        get :index
        expect(assigns(:lists)).to eq([my_list])
       end
     end

     describe "GET show" do
     it "returns http success" do
       get :show, params: { id: my_list.id }
       expect(response).to have_http_status(:success)
     end

     it "renders the #show view" do
       get :show, params: { id: my_list.id }
       expect(response).to render_template :show
     end

     it "assigns my_list to @list" do
       get :show, params: { id: my_list.id }
       expect(assigns(:list)).to eq(my_list)
     end
   end

   describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    it "initializes @list" do
      get :new
      expect(assigns(:list)).not_to be_nil
    end
  end

  describe "POST create" do
    it "increases the number of lists by 1" do
      expect{ post :create, params: { list: { name: RandomData.random_word, description: RandomData.random_sentence } } }.to change(List,:count).by(1)
    end

    it "assigns List.last to @list" do
      post :create, params: { list: { name: RandomData.random_word, description: RandomData.random_sentence } }
      expect(assigns(:list)).to eq List.last
    end

    it "redirects to the new list" do
      post :create, params: { list: { name: RandomData.random_word, description: RandomData.random_sentence } }
      expect(response).to redirect_to List.last
    end
  end

  describe "GET edit" do
     it "returns http success" do
       get :edit, params: {id: my_list.id}
       expect(response).to have_http_status(:success)
     end

     it "renders the #edit view" do
       get :edit, params: {id: my_list.id}
       expect(response).to render_template :edit
     end

     it "assigns list to be updated to @list" do
       get :edit, params: {id: my_list.id}
       list_instance = assigns(:list)

       expect(list_instance.id).to eq my_list.id
       expect(list_instance.name).to eq my_list.name
       expect(list_instance.description).to eq my_list.description
     end
   end

   describe "PUT update" do
     it "updates list with expected attributes" do
       new_name = RandomData.random_word
       new_description = RandomData.random_sentence

       put :update, params: { id: my_list.id, list: { name: new_name, description: new_description } }

       updated_list = assigns(:list)
       expect(updated_list.id).to eq my_list.id
       expect(updated_list.name).to eq new_name
       expect(updated_list.description).to eq new_description
     end

     it "redirects to the updated list" do
       new_name = RandomData.random_word
       new_description = RandomData.random_sentence

       put :update, params: { id: my_list.id, list: { name: new_name, description: new_description } }
       expect(response).to redirect_to my_list
     end
   end

   describe "DELETE destroy" do
     it "deletes the list" do
       delete :destroy, params: { id: my_list.id }
       count = Item.where({id: my_list.id}).size
       expect(count).to eq 0
     end

     it "redirects to list index" do
       delete :destroy, params: { id: my_list.id }
       expect(response).to redirect_to lists_path
     end
   end
 end
end
