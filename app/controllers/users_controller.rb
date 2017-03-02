class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy,:cheer]
  # 権限があるか認証
  before_action :is_user_permitted, except:[:index,:show]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json

  def show
    @posts=@user.posts.order("id desc")
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
    # 応援しているかを取得、または新規作成
    cheer=current_user.cheers.find_or_create_by(recipient_id:params[:cheer][:recipient_id])
    # 応援しているかどうかを入れかえる
    cheer.is_valid = !params[:cheer][:is_valid]
    if cheer.save
      puts "something"
        # 何かを返したい→その結果ボタンが入れ替わる
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:nickname,:email,:image)
    end

    def is_user_permitted()
      # 編集、削除などの権限があるか確認
      if !user_signed_in? || @user != current_user
      # 非ログインユーザー、またはログインした別ユーザーの場合トップにリダイレク
        redirect_to root_path
      end
    end
end
