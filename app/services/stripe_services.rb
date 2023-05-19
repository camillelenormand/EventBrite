require 'stripe'

module StripeServices

  def initialize
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
  end

  def create_stripe_customer(email)
    customer = Stripe::Customer.create(email: email)
    return customer.id
  end

end
