class Support < ActionMailer::Base
  default from: "info@mamebro.com"

  def are_you_ok(address)
    mail(to: address.to_s, subject: "ブラザーからお便りが届きました")
  end
end
