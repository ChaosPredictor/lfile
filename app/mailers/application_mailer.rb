class ApplicationMailer < ActionMailer::Base
  #default from: "dmitrykuznichov@gmail.com"
  default from: "no-reply@lfie.download"
  layout 'mailer'
end
