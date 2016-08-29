class ApplicationMailer < ActionMailer::Base
  #default from: "dmitrykuznichov@gmail.com"
  default from: "no-reply@lfile.download"
  layout 'mailer'
end
