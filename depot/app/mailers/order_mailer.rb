class OrderMailer < ApplicationMailer
  PUBLIC_PATH = Rails.public_path.join('images')
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.received.subject
  #
  def received(order)
    @order = order
    attach_product_images(order)
    add_process_id_headers
    I18n.with_locale(order.user.language_preference) do
      mail to: order.email, subject: 'Pragmatic Store Order Confirmation'
    end
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.shipped.subject
  #
  def shipped
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  private

    def attach_product_images(order)
      order.line_items.each do |line_item|
        line_item.product.images.each do |image|
          attachments.inline[image.filename.to_s] = File.read(PUBLIC_PATH.join(image.filepath))
        end
      end
    end

    def add_process_id_headers
      headers['X-SYSTEM-PROCESS-ID'] = Process.pid
    end
end
