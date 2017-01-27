class ApplicationMailer < ActionMailer::Base
    default from: Rails.configuration.contact_email
    layout 'mailer'
end
