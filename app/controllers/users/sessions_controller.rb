class Users::SessionsController < Devise::SessionsController

    def after_sign_in_path_for(users)
      if current_user.is_admin == true
        users_path
      else
        my_document_path(current_user)
      end
    end
end