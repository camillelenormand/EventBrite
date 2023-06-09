class CheckoutController < ApplicationController
  include CheckoutHelper
  include StripeServices
  before_action :authenticate_user!

  def create
    redirect_to event_path(params[:event_id]), alert: "You are already registered to this event" and return if is_event_attendee?(params[:event_id], current_user)
    redirect_to event_path(params[:event_id]), alert: "You can't register to your own event" and return if is_admin?(params[:event_id], current_user)

    @user = current_user
    @event = params[:event_id]
    @total = params[:total].to_d
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: 'eur',
            unit_amount: (@total*100).to_i,
            product_data: {
              name: "Stripe payment",
            },
          },
          quantity: 1
        },
      ],
      mode: 'payment',
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url, 
    )

    stripe_customer_id = create_stripe_customer(current_user.email)
    current_user.update(stripe_id: stripe_customer_id)
    create_attendee(current_user.id, @event)

    redirect_to @session.url, allow_other_host: true
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

  def cancel
  end
end
