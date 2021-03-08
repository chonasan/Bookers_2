class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!,except: [:top, :about]
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end

  def after_sign_in_path_for(resource)
  user_path(current_user)# ログイン後に遷移するpathを設定
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = "Signed out successfully."
    root_path # ログアウト後に遷移するpathを設定
  end

  Refile.secret_key = 'c46365b615ac5b42ce9a4ebb1c2b7e5be818a31a27a37e970adcf550af29a1c35f77be3f2ee01f5063997fe390157848d389dbc4099cc0fd506e9f1455c64261'

end
