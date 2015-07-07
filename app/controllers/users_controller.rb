Class UsersController < ActiveRecord::ApplicationController
before_action :authenticate_with_token!
def index
    @user = User.all
      render json: { user: @user.as_json(only: [:id, :fullname, :username, :email]) },
             status: :ok
    end

  def show
    @user = User.find(params[:user_id])
    render json: { user: @user.as_json(only: [:id, :full_name, :username,
                                              :email, :accesstoken]) }
  end

  def register
    passhash = Digest::SHA1.hexdigest(params[:password])
    @user = User.new(email: params[:email],
                     username: params[:username],
                     fullname: params[:full_name],
                     password: passhash)
    if @user.save
        render json: { user: @user.as_json(only: [:id, :username, :email, :accesstoken]) },
        status: :created
    else
      render json: { errors: @user.errors.full_messages },
        status: :unprocessable_entity
    end
  end

  def login
    passhash = Digest::SHA1.hexdigest(params[:password])
    @user = User.find_by(username: params[:username], password: passhash)

    if @user

      render json: { user: @user.as_json(only: [:id, :full_name, :username,
                                                :email, :accesstoken]) },
             status: :ok
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
      end
    end
