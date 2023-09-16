class TransactionMailer < ApplicationMailer
  def accept_email user
    @user = user
    mail(to: user.email, subject: t("mail.accepted"))
  end

  def deny_email user
    @user = user
    mail(to: user.email, subject: t("mail.denied"))
  end
end
