class UsersController < ApplicationController
before_action :authenticate_with_token!, only: [:destroy]
  def index
    @user = User.all
    render json: { user: @user.as_json(only: [:id, :first_name, :last_name, :username, :email]) },
               status: :ok
  end

  def show
    @user = User.find_by(username: params[:username])
      if @user
        render json: { user: @user.as_json(only: [:id, :first_name, :last_name, :username,
                                              :email]) }
      else
        render json: { error: @user.errors.full_messages }, status: :bad_request
      end
  end

  def register
    passhash = Digest::SHA1.hexdigest(params[:password])
    @user = User.new(email: params[:email],
                     username: params[:username],
                     first_name: params[:first_name],
                     last_name: params[:last_name],
                     password: passhash)
    if @user.save
        render json: { user: @user.as_json(only: [:id, :username, :email,
                                                  :access_token, :first_name,
                                                  :last_name]) },
        status: :created
    else
      render json: { errors: @user.errors.full_messages },
        status: :unprocessable_entity
    end

  end

  def login
    passhash = Digest::SHA1.hexdigest(params[:password])
    # @user = User.find_by(username: params[:username], password: passhash)

    @user = User.find_by(username: params[:username])

    if @user.password == passhash
      render json: { user: @user.as_json(except: [:created_at, :updated_at, :password]) },
                     status: :created
    else
      render json: { errors: "Invalid Username or Password." }, status: :unprocessable_entity
    end

      # if @user
      # render json: { user: @user.as_json(only: [:id, :first_name, :last_name, :username,
      #                                           :email, :access_token]) },
      #        status: :ok
      # else
      # render json: { errors: @user.errors.full_messages },
      #        status: :unprocessable_entity
      # end
  end


  def destroy
    @user = User.find_by(username: params[:username])
    if @user
      if current_user.access_token == @user.access_token
        if @user.destroy
          render json: { message: "User deleted." }, status: :no_content
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { errors: "Unauthorized user to delete this user." }, status: :unauthorized
      end
    else
      render json: { errors: "No user found with specified ID." }, status: :unprocessable_entity
    end
  end
end
