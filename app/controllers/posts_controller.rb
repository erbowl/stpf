class PostsController < ApplicationController

  before_action :move_to_index, except: :index

  def index
    @posts = Post.all.order('id DESC').page(params[:page]).per(5)
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

end
