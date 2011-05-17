class VideosController < ApplicationController
  def index
    @videos = Video.all.sort_by(&:hot).reverse
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
    unless @embedly.provider_name == nil 
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
        @video.vote_up(current_user)
        redirect_to @video, :notice => "Successfully submitted video."
      else
        render :action => 'new'
      end
    else
      redirect_to new_video_path, :notice => "Sorry, you submitted an invalid video url."
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
  
  def vote_up
    @video = Video.find params[:video_id]
    @video.vote_up(current_user)
    respond_to do |format|
      format.js
      format.html { redirect_to @video }
    end
  end
  
  def vote_down
    @video = Video.find params[:video_id]
    @video.vote_down(current_user)
    respond_to do |format|
      format.js { }
      format.html { redirect_to @video }
    end
  end
  
  def remove_vote_up
    @video = Video.find params[:video_id]
    @video.remove_vote_up(current_user)
    respond_to do |format|
      format.js
      format.html { redirect_to @video }
    end
  end
  
  def remove_vote_down
    @video = Video.find params[:video_id]
    @video.remove_vote_down(current_user)
    respond_to do |format|
      format.js
      format.html { redirect_to @video }
    end
  end
  
  def reverse_vote_up
    @video = Video.find params[:video_id]
    @video.reverse_vote_up(current_user)
    respond_to do |format|
      format.js
      format.html { redirect_to @video }
    end
  end
  
  def reverse_vote_down
    @video = Video.find params[:video_id]
    @video.reverse_vote_down(current_user)
    respond_to do |format|
      format.js
      format.html { redirect_to @video }
    end
  end
  
  def show_video_ajax
    @video = Video.find params[:video_id]
    @embed = @video.embed
    respond_to do |format|
      format.js
      format.html { redirect_to @video }
    end
  end
  
  def hide_video_ajax
    @video = Video.find params[:video_id]
    respond_to do |format|
      format.js
      format.html { redirect_to @video }
    end
  end
  
end
