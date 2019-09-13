module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_user
    end

    private
    
    def find_user
      token = request.params[:token]
      decoded_token = JWT.decode(
        token,
        'butter',
        # Rails.application.credentials.fetch(:secret_key_base),
        true,
        { algorithm: 'HS256' }
      )
      if current_user = User.find_by(id: decoded_token[0]["user_id"])
        return current_user
      else
        nil
      end
    end
  end
end
