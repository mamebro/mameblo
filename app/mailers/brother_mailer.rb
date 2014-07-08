class BrotherMailer < ActionMailer::Base
  default from: "info@mamebro.com"

  def password_reset(brother)
    @brother = brother
    mail to: brother.email,
         subject: "【まめぶろ】パスワード再設定"
  end

  def verify_alter_email(brother)
    @brother = brother
    @url = "http://localhost:3000/verify_email/#{brother.alter_email_token}"

    mail to: brother.alter_email,
         subject: "【まめぶろ】メールアドレス変更"
  end
end
