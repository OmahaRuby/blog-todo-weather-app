class ItemsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @items = items
  end

  def new
    @item = items.new
  end

  def create
    @item = items.new(item_params)

    if @item.save
      flash[:notice] = "#{@item.title} was created successfully."

      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def edit
    @item = items.find(params[:id])
  end

  def update
    @item = items.find(params[:id])

    if @item.update_attributes(item_params)
      flash[:notice] = "#{@item.title} was updated successfully."

      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def show
    @item = items.find(params[:id])
  end

  def destroy
    @item = items.find(params[:id])

    @item.destroy!

    redirect_to items_path
  end

  def mark_as_done
    @item = items.find(params[:item_id])

    @item.completed_at = Time.now
    @item.save!

    flash[:notice] = "#{@item.title} was marked as done."

    redirect_to :back
  end

  private
  
  def items
    current_user.items
  end

  def item_params
    params.require(:item).permit(:title, :body)
  end
end
