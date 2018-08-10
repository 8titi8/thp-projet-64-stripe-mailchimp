class ChargesController < ApplicationController

  def new
    @user = User.new
  end
  # copier du texte à propos de la gem stripe sur stripe.com
  def create

    @url = "https://la-fonte-des-graisses.herokuapp.com/"
    @user = User.new
    @user.name = params[:name]
    @user.email = params[:email]
    @user.save

    # Amount in cents
    @amount = 39999

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'eur'
    )

     UserMailer.welcome_email(@user).deliver_now

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end
