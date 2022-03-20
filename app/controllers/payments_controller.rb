class PaymentsController < ApplicationController

    def index
        @paymentsb = current_user.buyer_payments
        @paymentss = current_user.seller_payments
        # I actually blame rails for this. So much of the query jank here comes from the double ownership constraint.
    end

end
