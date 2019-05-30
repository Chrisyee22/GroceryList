class ItemsController < ApplicationController


  def show
    @item = Item.find(params[:id])
  end

  def new
    @list = List.find(params[:list_id])
    @item = Item.new
  end

  def create
    @list = List.find(params[:list_id])
    @item = @list.items.build(item_params)

    if @item.save
      flash[:notice] = "Item was added to list"
      redirect_to [@list]
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
    @item.assign_attributes(item_params)
    if @item.save
      flash[:notice] =  "New Item added"
      redirect_to [@item.list]
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

  private
  def item_params
    params.require(:item).permit(:title, :amount, :completed)
  end


end
