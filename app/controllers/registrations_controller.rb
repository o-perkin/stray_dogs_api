class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    @user = User.new(sign_up_params)
    if @user.save
      render json: @user
    else
      render json: { errors: @user.errors }
    end
  end

  def destroy
    @user.destroy
    render json: {message: "User destroyed"}, status: :ok
  end

  private
    def sign_up_params
      params.permit(:email, :first_name, :last_name, :password, :password_confirmation)
    end
end
