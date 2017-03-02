class PostsController < ApplicationController

  before_action :move_to_index, except: :index
  before_action :set_post,only: [:edit, :update,:destroy]

  def index
    @posts = Post.all.order('id DESC').page(params[:page]).per(5)
  end

  def edit
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to user_path(current_user), success: 'Posts was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def new
    @post=current_user.posts.build
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to current_user, success: '投稿は削除されました' }
    end
  end

  def create
    # Post.create(title: post_params[:title], content: post_params[:content], user_id: current_user.id)
    @post = current_user.posts.build(post_params)
    if @post.save
      msg = "新しい投稿が公開されました"
      msg = "新しい下書きが投稿されました（非公開）" if @post.is_draft
      redirect_to user_path(current_user),success:msg
    else
      flash.now[:danger]="空欄のまま保存することはできません"
      render :new
    end
  end

  private
  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title,:content,:is_draft)
  end

end
