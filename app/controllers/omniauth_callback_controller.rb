class OmniauthCallbackController < ApplicationController

	# def facebook
 #        @user =  User.save_omni_auth_details(request.env['omniauth.auth'])
 #        if @user.persisted?
 #          sign_in_and_redirect @user, :event => :authentication 
 #          set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
 #        else
 #          session["devise.facebook_data"] = request.env["omniauth.auth"]
 #          redirect_to new_user_registration_url
 #        end
 #    end

 #    def after_sign_in_path_for(resource)
 #      super resource
 #    end
end
