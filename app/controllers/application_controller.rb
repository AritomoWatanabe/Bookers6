class ApplicationController < ActionController::Base

	protect_from_forgery with: :exception

    def login_check
      if current_user.nil?
        redirect_to root_url
      end
    end

    def after_sign_in_path_for(resource)
      user_path(current_user.id)
    end

    def after_sign_out_path_for(resource)
      session[:previous_url] || root_path
    end

  	# ログイン済ユーザーのみにアクセスを許可する
  	# before_action :authenticate_user!

  	# deviseコントローラーにストロングパラメータを追加する
  	before_action :configure_permitted_parameters, if: :devise_controller?

  	protected
  	def configure_permitted_parameters
    	# サインアップ時にnameのストロングパラメータを追加
    	devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    	# サインイン時にnameのストロングパラメータを追加
    	devise_parameter_sanitizer.permit(:sign_in, keys: [:name])

    	# アカウント編集の時にnameとprofileのストロングパラメータを追加
    	devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction])
  	end

end
