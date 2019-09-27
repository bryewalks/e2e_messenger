class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  validates :body, presence: true

  # after_create_commit do
  #   MessageCreationEventBroadcastJob.perform_later(self)
  # end

  def encrypt_body(password)
    len   = ActiveSupport::MessageEncryptor.key_len
    # salt  = SecureRandom.hex(len)
    key   = ActiveSupport::KeyGenerator.new(Rails.application.secrets.secret_key_base).generate_key(password, len)
    crypt = ActiveSupport::MessageEncryptor.new(key)
    encrypted_data = crypt.encrypt_and_sign(self.body)
    self.body = encrypted_data
  end

  def decrypt_body(password)
    len   = ActiveSupport::MessageEncryptor.key_len
    key   = ActiveSupport::KeyGenerator.new(Rails.application.secrets.secret_key_base).generate_key(password, len)
    crypt = ActiveSupport::MessageEncryptor.new(key)
    crypt.decrypt_and_verify(self.body)
  end
end
