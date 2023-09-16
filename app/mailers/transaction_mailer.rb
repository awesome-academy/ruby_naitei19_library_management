class TransactionMailer < ApplicationMailer
  def accept_email user
    @user = user
    mail(to: user.email, subject: t("mail.accepted"))
  end

  def deny_email user
    @user = user
    mail(to: user.email, subject: t("mail.denied"))
  end

  def notify_expire user, transaction
    @user = user
    @transaction = transaction
    mail(to: user.email, subject: t("mail.expire"))
  end
end
