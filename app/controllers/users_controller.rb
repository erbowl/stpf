class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy,:cheer]
  # 権限があるか認証
  before_action :is_user_permitted, except:[:index,:show,:cheer,:search]
  # GET /users
  # GET /users.json
  def index
    if 1==1
      @users = User.all
    else
      # アクセスランキング
      ids=REDIS.zrevrangebyscore "user/total", "+inf", 0, limit: [0, 20]
      @users=[]
      ids.each do |id|
        @users.push(User.find(id))
      end
    end

  end

  def search
    # gem ransack利用
    @search = User.search(params[:q])
    @users = @search.result
    flash.now[:success]="ユーザーが見つかりました(仮置き) "
  end

  def show
    @posts=@user.posts.order("id desc")
    # お役御免
    # impressionist(@user, nil, :unique => [:session_hash]) unless @user==current_user
    if true
      # if params[:session][:user_imp][@user.id].nil? セッションが見当たらない。
      REDIS.zincrby "user/total", 1, @user.id unless @user==current_user
      REDIS.zincrby "user/daily/#{Date.today.to_s}", 1, @user.id
    end
    @y_rank=get_rank("user/daily/#{Date.yesterday.to_s}")
    @t_rank=get_rank("user/total")
    @c_rank=get_rank("cheer")

    @page_views = (REDIS.zscore("user/total",@user.id)) || 0
    @page_views = @page_views.round

    @cheers=Cheer.where(recipient_id:@user.id,is_valid:true).select(:user_id)
    @user_1=User.new unless user_signed_in?
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, success: 'プロフィールが更新されました！みんなに見てもらおう' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        flash.now[:danger]="必須事項を入力してください"
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, success: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def cheer
    # 応援しているかを新規作成
    cheer=current_user.cheers.find_or_initialize_by(recipient_id:params[:id])
    cheer.is_valid=params[:is_valid]
    # ランキング作成用
    if params[:is_valid]
      REDIS.zincrby "cheer", 1, @user.id
    else
      REDIS.zincrby "cheer", -1, @user.id
    end
    cheer.save
    head 200
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:nickname,:email,:image,:twitter,:instagram,:studyplus,:department,:university,:age,:gender,:comment,:like_subject,:dislike_subject)
    end

    def is_user_permitted()
      # 編集、削除などの権限があるか確認
      if !user_signed_in? || @user != current_user
      # 非ログインユーザー、またはログインした別ユーザーの場合トップにリダイレク
        redirect_to root_path
      end
    end

    def get_rank(redis)
      rank=(REDIS.zrank redis, @user.id) || User.count
      rank=rank+1 unless rank==User.count
      rank
    end
end
