class PaymentsController < ApplicationController

    def index
        # @payments = Payment.where(buyer_id: current_user.id)
        @paymentsb = current_user.buyer_payments
        @paymentss = current_user.seller_payments
    end

end
