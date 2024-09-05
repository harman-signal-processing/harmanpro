class ServiceController < ApplicationController
  def index
    @contact_message = ContactMessage.new
    @banner = Resource.find_by(name:"Banner: Service")
  end

  def create_contact_message
    @contact_message = ContactMessage.new(contact_message_params)
    if verify_recaptcha(model: @contact_message) & @contact_message.save
      redirect_to thankyou_path
    else
      render action: :index
    end
  end

  private

  def contact_message_params
    params.require(:contact_message).permit(
      :message_type,
      :name,
      :email,
      :brand_id,
      :message,
      :product,
      :operating_system,
      :company,
      :account_number,
      :billing_address,
      :billing_city,
      :billing_state,
      :billing_zip,
      :shipping_address,
      :shipping_city,
      :shipping_state,
      :shipping_zip,
      :product_serial_number,
      :warranty,
      :purchased_on,
      :part_number,
      :shipping_country,
      :attachment
    )
  end
end
