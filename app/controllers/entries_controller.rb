class EntriesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @entries = entries
  end

  def new
    @entry = entries.new
  end

  def create
    @entry = entries.new(entry_params)

    if @entry.save
      flash[:notice] = "#{@entry.title} was created successfully."

      redirect_to entry_path(@entry)
    else
      render :new
    end
  end

  def edit
    @entry = entries.find(params[:id])
  end

  def update
    @entry = entries.find(params[:id])

    if @entry.update_attributes(entry_params)
      flash[:notice] = "#{@entry.title} was updated successfully."

      redirect_to entry_path(@entry)
    else
      render :edit
    end
  end

  def show
    @entry = entries.find(params[:id])
  end

  def destroy
    @entry = entries.find(params[:id])

    @entry.destroy!

    redirect_to entries_path
  end

  def mark_as_done
    @entry = entries.find(params[:entry_id])

    @entry.completed_at = Time.now
    @entry.save!

    flash[:notice] = "#{@entry.title} was marked as done."

    redirect_to :back
  end

  private
  
  def blog
    current_user.blogs.find( params[:blog_id] )
  end
  
  def entries
    blog.entries
  end

  def entry_params
    params.require(:entry).permit(:title, :body)
  end
end
