class UsersController < ApplicationController

  def index
  end

  def show
    @nickname = User.find(params[:id]).nickname
    @posts = User.find(params[:id]).posts.page(params[:page]).per(5).order("created_at DESC")
  end

  def nickname
    @nickname = params[:nickname]
    @posts = User.find_by(nickname: params[:nickname]).posts.page(params[:page]).per(5).order("created_at DESC")
  end

end
