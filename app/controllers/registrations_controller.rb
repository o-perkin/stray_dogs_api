class RegistrationsController < Devise::RegistrationsController
  clear_respond_to
  respond_to :json

  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message! :notice, :destroyed
    yield resource if block_given?
    render json: { message: "User deleted" }, status: :ok
  end
end
