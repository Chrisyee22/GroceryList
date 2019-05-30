class ItemsController < ApplicationController

  def show
    @item = Item.find(params[:id])
  end

  def new
    @list = List.find(params[:list_id])
    @item = Item.new
  end

  def create
    @item = Item.new
    @item.title = params[:item][:title]
    @item.amount = params[:item][:amount]
    @item.completed = params[:item][:completed]
    @list = List.find(params[:list_id])
    @item.list = @list

    if @item.save
      flash[:notice] = "Item was added to list"
      redirect_to [@list, @item]
    else
      flash.now[:alert] = "There was an error adding the item to the list. Please try again"
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.title = params[:item][:title]
    @item.amount = params[:item][:amount]
    @item.completed = params[:item][:completed]

    if @item.save
      flash[:notice] =  "New Item added"
      redirect_to [@item.list, @item]
    else
      flash[:notice] = "There was an error saving the new item. Please try again."
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      flash[:notice] = "\"#{@item.title}\" was deleted."
      redirect_to @item.list
    else
      flash.now[:alert] = "There was an error deleting the item"
      render :index
    end
  end
end
