class ListsController < ApplicationController
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
    @list = List.new
    @list.name = params[:list][:name]
    @list.description = params[:list][:description]
    @list.public = params[:list][:public]

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
    @list.name = params[:list][:name]
    @list.description = params[:list][:description]
    @list.public = params[:list][:public]

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
end
