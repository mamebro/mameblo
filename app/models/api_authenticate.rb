class ApiAuthenticate < ActiveRecord::Base
  belongs_to :brother

  before_save do
    self.token = Digest::SHA1.hexdigest(SecureRandom.urlsafe_base64.to_s)
  end
end
