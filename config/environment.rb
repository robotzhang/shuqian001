# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Shuqian001::Application.initialize!

# config for email stmp server
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :address => "smtp.exmail.qq.com",
    :port => 25,
    :authentication => :login,
    :user_name => "no-repay@shuqian001.com",
    :password => "ShuQian001"   #用户名和密码是163邮箱的，需要验证
}
