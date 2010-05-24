class AlbumsController < ApplicationController
  before_filter :require_user, :only => [:index, :create, :new, :show, :edit, :update, :destroy]

  def index
    @albums = Album.all(:conditions => {"user_id" => current_user.id})
  end

  def new
    Album.new
  end

  def create
    @album = Album.new(params[:album].merge(:user => current_user))
    if(@album.save)
      flash[:notice] = "Album created"
      redirect_to album_url(@album.id)
    end
  end
end
