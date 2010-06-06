class PhotosController < ApplicationController
  before_filter :require_user

  def index
    @photos = Photo.all(:conditions => {"album_id" => params[:album_id]})
  end

  def new
    @user = Photo.new
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(params[:photo])
      flash[:notice] = "Photo updated!"
      redirect_to album_photos_url(params[:album_id])
    else
      render :action => :edit
    end
  end

  def create
    @photo = Photo.new(params[:photo].merge({:album_id => params[:album_id]}))
    if(@photo.save)
      flash[:notice] = "Photo created"
      redirect_to album_photos_url(params[:album_id])
    end
  end

end
