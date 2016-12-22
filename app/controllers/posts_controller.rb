class PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :owned_post, only: [:edit, :update, :destroy]

  def index
    @posts = (Post.of_followed_users(current_user.following) + current_user.posts).sort_by(&:created_at).reverse!
  end

  def browse
    @posts = Post.all.order('created_at DESC')
    render :browse, :local => {:posts => @posts}
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @post.update(edit_params)
    redirect_to @post
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def edit_params
    params.require(:post).permit(:caption)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def owned_post
    if current_user != Post.find(params[:id]).user
      redirect_to posts_path
    end
  end

end
