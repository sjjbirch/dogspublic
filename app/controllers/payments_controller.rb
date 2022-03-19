class PaymentsController < ApplicationController

    def index
        @paymentsb = current_user.buyer_payments
        @paymentss = current_user.seller_payments
    end

end
