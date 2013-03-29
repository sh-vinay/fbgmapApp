OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '555819054450009', '42c6e08ef2b14a60f14db22e1e09b445' , :scope => 'email, user_about_me,user_hometown,user_location,friends_location,friends_hometown'
 
end
