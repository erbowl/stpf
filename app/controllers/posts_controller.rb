class PostsController < ApplicationController

  before_action :move_to_index, except: :index
  before_action :set_post,only: [:edit, :update]

  def index
    @posts = Post.all.order('id DESC').page(params[:page]).per(5)
  end

  def edit
  end

  def update
    respond_to do |format|
      if @post.update(post_params_new)
        format.html { redirect_to current_user, success: 'Posts was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def new
  end

  def create
    Post.create(title: post_params[:title], content: post_params[:content], user_id: current_user.id)
    #binding.pry
  end

  private
  def post_params
    params.permit(:title,:content)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params_new
    params.require(:post).permit(:title,:content)
  end

end
