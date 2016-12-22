class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_post

  def index
    respond_to do |format|
      format.html {redirect_to root_path}
      format.js { render :load_all, :locals => {:post => @post} }
    end
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id

    @comment.save
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render :create, :locals => {:comment => @comment, :post => @post} }
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])

    if (@comment.user == current_user)
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js { render :destroy, :locals => {:comment => @comment, :post => @post} }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

end
