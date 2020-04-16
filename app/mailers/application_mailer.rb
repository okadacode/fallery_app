class ApplicationMailer < ActionMailer::Base
  default from: 'info@fallery.com', charset: 'ISO-2022-JP'
  layout 'mailer'
end
