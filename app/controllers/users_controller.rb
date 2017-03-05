class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy,:cheer]
  # 権限があるか認証
  before_action :is_user_permitted, except:[:index,:show,:cheer]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json

  def show
    @posts=@user.posts.order("id desc")
    @cheers=Cheer.where(recipient_id:@user.id)
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
    # 応援しているかを新規作成
    cheer=current_user.cheers.build(recipient_id:params[:id],is_valid:params[:is_valid])
    # 保存する
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
