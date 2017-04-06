class StaticPagesController < ApplicationController
  def contactus
  end

  def enquiry_contact_details
    fullname= params[:full_name]
    email = params[:email]
    msg=params[:message]
    mobile_number= params[:number]
    UserMailer.enquiry_contact_details(fullname,email,msg,mobile_number).deliver_now!
    flash[:notice] = 'Thank you for contact us. We will update you soon..'
    redirect_to root_path
  end
end
