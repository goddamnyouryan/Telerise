class VideosController < ApplicationController
  before_filter :current_user_login, :only => :create
  
  def index
    @videos = Video.all.sort_by(&:hot).reverse
    @videos = Kaminari.paginate_array(@videos).page(params[:page]).per(25)
  end

  def show
    @video = Video.find(params[:id])
    @comment = Comment.new
    @comments = @video.comments.sort_by(&:ranking).reverse
  end

  def new
    if current_user
      @video = Video.new
    else
      flash[:error] = "You must be signed in to submit a new video."
      redirect_to root_path
    end
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
      redirect_to root_path, :notice => "Sorry, you submitted an invalid video url."
    end
  end

  def edit
    @video = Video.find(params[:id])
    unless current_user == @video.user && Time.now < (@video.created_at + 1.hour )
      redirect_to root_path, :notice => "Sorry you can only edit a video up to one hour after submitting it."
    end
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
    redirect_to videos_url, :notice => "Successfully deleted video."
  end
  
  def best
    @videos = Video.all.sort_by(&:best).reverse
    @videos = Kaminari.paginate_array(@videos).page(params[:page]).per(25)
  end
  
  def new_submissions
    @videos = Video.all.sort_by(&:created_at).reverse
    @videos = Kaminari.paginate_array(@videos).page(params[:page]).per(25)
  end
  
  def controversial
    @videos = Video.all.sort_by(&:controversial).reverse
    @videos = Kaminari.paginate_array(@videos).page(params[:page]).per(25)
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
  
  def check_url
    api = Embedly::API.new :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; ryan.macinnes@gmail.com)'
    obj = api.oembed :url => params[:video][:url]
    @embedly = obj[0]
    respond_to do |format|
      format.json { render :json => @embedly.type == "video" }
    end
  end
  
  def share_toggle
    respond_to do |format|
      format.js
      format.html { redirect_to @video }
    end
  end
  
end
