class ListsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, except: [:index, :new, :create]

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user

    if @list.save
      redirect_to @list, notice: "List was saved successfully."
    else
      flash.now[:alert] = "Error creating list. Please try again."
      render :new
    end
  end

  def edit
      @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])
    @list.assign_attributes(list_params)

    if @list.save
       flash[:notice] = "list was updated."
      redirect_to @list
    else
      flash.now[:alert] = "Error saving list. Please try again."
      render :edit
    end
  end

  def destroy
    @list = List.find(params[:id])

     if @list.destroy
       flash[:notice] = "\"#{@list.name}\" was deleted successfully."
       redirect_to action: :index
     else
       flash.now[:alert] = "There was an error deleting the list."
       render :show
     end
   end

   private

   def list_params
     params.require(:list).permit(:name, :description, :public)
   end

   def authorize_user
     list = List.find(params[:id])

     unless current_user == list.user || current_user.admin?
       flash[:alert] = "You must be an admin to do that."
       redirect_to lists_path
     end
   end

end
