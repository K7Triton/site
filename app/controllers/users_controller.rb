class UsersController < ApplicationController

  before_filter :find_item,       only: [:show, :edit, :update, :destroy, :upvote]
  before_filter :check_if_admin,  only: [:destroy,]

  def index
    @users = User.all
  end

  def show
    unless @user
      render text: "Page not found", status: 404
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render "new"
    end
  end

  def update
    @user.update_attributes(user_params)
    if @user.errors.empty?
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to action: "index"
  end

  def upvote
    @user.increment!(:votes_count)
    redirect_to action: "index"
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :phone, :gender, :password, :password_confirmation, :image)
  end

  def find_item
    @user = User.where(id: params[:id]).first
    render_404 unless @user
  end

end
