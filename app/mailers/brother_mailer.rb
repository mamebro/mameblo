class BrotherMailer < ActionMailer::Base
  default from: "info@mamebro.com"

  def password_reset(brother)
    @brother = brother
    mail to: brother.email,
         subject: "【まめぶろ】パスワード再設定"
  end
end
