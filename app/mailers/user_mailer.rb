class UserMailer < ApplicationMailer
  def enquiry_contact_details(fullname,email,msg,mobile_number)
    @name = fullname
    @email = email
    @msg = msg
    @number = mobile_number
    mail( :to => "info@voyajers.com",  :from => email,
    :subject => 'New Inquery for the voyajers' )
  end
end
