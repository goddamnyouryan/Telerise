class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(params[:comment])
    @video = Video.find params[:comment][:video_id]
    @comment.user_id = current_user.id
    if @comment.save
      @comment.vote_up(current_user)
      respond_to do |format|
        format.js
        format.html { redirect_to @video }
      end
    else
      redirect_to root_path, :notice => "Something went wrong!"
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to @comment, :notice  => "Successfully updated comment."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to comments_url, :notice => "Successfully destroyed comment."
  end
  
  def vote_up
    @comment = Comment.find params[:comment_id]
    @video = @comment.video
    @comment.vote_up(current_user)
    respond_to do |format|
      format.js
      format.html { redirect_to @video }
    end
  end
  
  def vote_down
    @comment = Comment.find params[:comment_id]
    @video = @comment.video
    @comment.vote_down(current_user)
    respond_to do |format|
      format.js { }
      format.html { redirect_to @video }
    end
  end
  
  def remove_vote_up
    @comment = Comment.find params[:comment_id]
    @video = @comment.video
    @comment.remove_vote_up(current_user)
    respond_to do |format|
      format.js
      format.html { redirect_to @video }
    end
  end
  
  def remove_vote_down
    @comment = Comment.find params[:comment_id]
    @video = @comment.video
    @comment.remove_vote_down(current_user)
    respond_to do |format|
      format.js
      format.html { redirect_to @video }
    end
  end
  
  def reverse_vote_up
    @comment = Comment.find params[:comment_id]
    @video = @comment.video
    @comment.reverse_vote_up(current_user)
    respond_to do |format|
      format.js
      format.html { redirect_to @video }
    end
  end
  
  def reverse_vote_down
    @comment = Comment.find params[:comment_id]
    @video = @comment.video
    @comment.reverse_vote_down(current_user)
    respond_to do |format|
      format.js
      format.html { redirect_to @video }
    end
  end
  
end
