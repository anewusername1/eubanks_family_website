class PhotosController < ApplicationController
  before_filter :require_user

  def index
    @album = Album.find(params[:album_id])
    @photos = Photo.all(:conditions => {"album_id" => params[:album_id]})
  end

  def new
    @album = Album.find(params[:album_id])
    @photo = Photo.new
  end

  def edit
    @album = Album.find(params[:album_id])
    @photo = Photo.find(params[:id])
  end

  def show
    @album = Album.find(params[:album_id])
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(params[:photo].merge({:album_id => params[:album_id]}))
      flash[:notice] = "Photo updated!"
      redirect_to album_photos_url(params[:album_id])
    else
      render :action => :edit
    end
  end

  def create
    if(params["photo"])
      
      @photo = Photo.new(params[:photo].merge({:album_id => params[:album_id]}))
      if(@photo.save)
        flash[:notice] = "Photo created"
        redirect_to album_photos_url(params[:album_id])
      end
    end
  end

end
if(params["image"])
  @image_dir = "/u/apps/social_stats/shared/images"
  new_file_name = "#{@image_dir}/#{params[:Filename]}"
  FileUtils.mv(params["image"]["image"], new_file_name)
  @image = Image.new({:name => params[:Filename], :location => "#{@image_dir}/#{params[:Filename]}"})
  #@image.photo_content_type = MIME::Types.type_for(@image.photo_file_name).to_s
  respond_to do |format|
    if @image.save
      flash[:notice] = 'Image was successfully created.'
      #format.html { redirect_to(images_url) }
      format.xml  { render :xml => @image, :status => :created, :location => @image }
      format.json { render :json => { :result => 'success', :photo => images_url } }        
      format.js   
    else
      format.html { render :action => "new" }
      format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      format.json { render :json => { :result => 'error', :error => @image.errors.full_messages.to_sentence } }        
      format.js   
    end
  end
#   file_content_type = MIME::Types.type_for(@image.original_filename).to_s
#   new_file_name = "#{RAILS_ROOT}/tmp/images.zip"
#   FileUtils.mv(params["image"]["uploaded_data"], new_file_name)
#   @image_dir = "/u/apps/social_stats/shared/images"
#   
#   redirect_to images_url