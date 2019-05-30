require 'rails_helper'


RSpec.describe ItemsController, type: :controller do
  let(:my_user) { User.create!(name: "Misty Gish", email: "mistygish@mail.com", password: "password")}
  let(:my_list) { List.create!(user: my_user, name: RandomData.random_word, description: RandomData.random_sentence) }

  let(:my_item) { my_list.items.create!(title: RandomData.random_word, amount: RandomData.random_number, completed: false) }


  # describe "GET #show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe "GET #new" do
    it "returns http success" do
      get :new, params: { list_id: my_list.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new, params: { list_id: my_list.id }
      expect(response).to render_template :new
    end

    it "instaniates @item" do
      get :new, params: { list_id: my_list.id }
      expect(assigns(:item)).not_to be_nil
    end
  end

  describe "POST create" do
    it "inceases item count by 1" do
      expect{ post :create, params: { list_id: my_list.id, item: { title: RandomData.random_word, amount: RandomData.random_number, completed: false }}}.to change(Item,:count).by(1)
    end

    it "assigns the new item to @item" do
      post :create, params: { list_id: my_list.id, item: { title: RandomData.random_word, amount: RandomData.random_number, completed: false }}
      expect(assigns(:item)).to eq Item.last
    end

    it "redirects to the list with new item" do
      post :create, params: { list_id: my_list.id, item: { title: RandomData.random_word, amount: RandomData.random_number, completed: false }}
      expect(response).to redirect_to my_list
    end
  end
  #
  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: { list_id: my_list.id, id: my_item.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, params: { list_id: my_list.id, id: my_item.id }
      expect(response).to render_template :edit
    end

    it "assigns item to be updated to @item" do
      get :edit, params: { list_id: my_list.id, id: my_item.id }
      item_instance = assigns(:item)
      expect(item_instance.id).to eq my_item.id
      expect(item_instance.title).to eq my_item.title
      expect(item_instance.amount).to eq my_item.amount
      expect(item_instance.completed).to eq my_item.completed
    end
  end

  describe "PUT update" do
    it "updates item with expected attributes" do
      new_title = RandomData.random_word
      new_amount = RandomData.random_number
      new_completed = false

      put :update, params: { list_id: my_list.id, id: my_item.id, item: {title: new_title, amount: new_amount, completed: new_completed } }
      updated_item = assigns(:item)
      expect(updated_item.id).to eq my_item.id
      expect(updated_item.title).to eq new_title
      expect(updated_item.amount).to eq new_amount
      expect(updated_item.completed).to eq new_completed
    end

    it "redirects to the index view with updated item" do
      new_title = RandomData.random_word
      new_amount = RandomData.random_number
      new_completed = false

      put :update, params: { list_id: my_list.id, id: my_item.id, item: {title: new_title, amount: new_amount, completed: new_completed } }
      expect(response).to redirect_to my_list
    end
  end

  describe "DELETE destroy" do
    it "deletes the item" do
      delete :destroy, params: { list_id: my_list.id, id: my_item.id }
      count = Item.where({id: my_item.id}).size
      expect(count).to eq 0
    end
    it "redirects to list show" do
      delete :destroy, params:{ list_id: my_list.id, id: my_item.id }
      expect(response).to redirect_to my_list
    end
  end

end
