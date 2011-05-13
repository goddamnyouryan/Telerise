class VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def show
    @video = Video.find(params[:id])
    @comment = Comment.new
  end

  def new
    @video = Video.new
  end

  def create
    api = Embedly::API.new :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; ryan.macinnes@gmail.com)'
    obj = api.oembed :url => params[:video][:url]
    @embedly = obj[0]
    @video = Video.new(params[:video])
    @video.user_id = current_user.id
    @video.provider = @embedly.provider_name
    @video.height = @embedly.height
    @video.width = @embedly.width
    @video.embed = @embedly.html
    @video.thumb = @embedly.thumbnail_url
    @video.thumb_height = @embedly.thumbnail_height
    @video.thumb_width = @embedly.thumbnail_width
    if @video.save
      redirect_to @video, :notice => "Successfully submitted video."
    else
      render :action => 'new'
    end
  end

  def edit
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    if @video.update_attributes(params[:video])
      redirect_to @video, :notice  => "Successfully updated video."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    redirect_to videos_url, :notice => "Successfully destroyed video."
  end
end
