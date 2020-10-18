class Admin::UsersController < Admin::ApplicationController
  load_and_authorize_resource find_by: :uid, id_param: :uid

  def index
  end

  def show
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'User was successfully destroyed.'
  end
end
