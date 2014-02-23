class ApiAuthenticate < ActiveRecord::Base
  belongs_to :brother

  before_save do
    token = ''
    begin
      token = Digest::SHA1.hexdigest(SecureRandom.urlsafe_base64.to_s)
      authenticate = ApiAuthenticate.find_by token: token
    end while authenticate.present?

    self.token = token
  end
end
