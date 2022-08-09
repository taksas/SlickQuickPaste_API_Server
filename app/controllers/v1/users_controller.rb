class V1::UsersController < ApplicationController

    before_action :authenticate_v1_user!
    def index
        user_id = current_v1_user.id

        if params[:insert_text]
            Clipboard.where(user_id: user_id).delete_all
            
            text = params[:insert_text]
            clipboard = Clipboard.new(text: text)
            clipboard.user_id = current_v1_user.id
            clipboard.save
            render status: 200, json: { clipboard: clipboard }

        elsif Clipboard.find_by(user_id: user_id)
            clipboard = Clipboard.find_by(user_id: user_id)
            render status: 200, json: { clipboard: clipboard }

        else
            clipboard = Clipboard.new(text: "Welcome to SlickQuickPaste!")
            clipboard.user_id = current_v1_user.id
            clipboard.save
            render status: 200, json: { clipboard: clipboard }
        end
    end

end
