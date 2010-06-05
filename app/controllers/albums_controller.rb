class AlbumsController < ApplicationController
  before_filter :require_user, :only => [:index, :create, :new, :show, :edit, :update, :destroy]

  def index
    @albums = Album.all(:conditions => {"user_id" => current_user.id})
  end

  def new
    @user = Album.new
  end

  def edit
    @album = Album.find(params[:id])
  end

  def show
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(params[:album].merge(:user => current_user))
      flash[:notice] = "Album updated!"
      redirect_to album_url(@album.id)
    else
      render :action => :edit
    end
  end

  def create
    @album = Album.new(params[:album].merge(:user => current_user))
    if(@album.save)
      flash[:notice] = "Album created"
      redirect_to album_url(@album.id)
    end
  end
end
