class V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController


    



    private
     #ユーザー登録時に使用
     def sign_up_params
         params.require(:registration).permit(:email, :password, :password_confirmation, :session)
     end
     


end
