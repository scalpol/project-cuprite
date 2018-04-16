class BillingsController < ApplicationController
  before_action :set_orb_price, only: [:index, :create, :pre_pay]
  def index
    @billing = current_player.cart

  end

  def create
    cart = current_player.cart
    new_orbs = params[:orbs].to_i
    cost = new_orbs * @orb_current_price
    if cart.nil?
      Billing.create(orb_price: @orb_current_price, total_orbs: new_orbs, player: current_player, paid_amount: cost)
    else
      if cart.orb_price == @orb_current_price
        updated_orbs = cart.total_orbs + new_orbs
        updated_price = cart.paid_amount + (new_orbs * @orb_current_price)
        cart.update(total_orbs: updated_orbs, paid_amount: updated_price)
      else
        redirect_to billing_path, method: delete
        return
      end
    end
    redirect_to orbs_path, notice: 'Added to my bag'
  end

  def destroy
    current_player.cart.destroy
    redirect_to orbs_path
  end

  def pre_pay
    cart = current_player.cart

    payment = PayPal::SDK::REST::Payment.new({
  :intent =>  "sale",
  :payer =>  {
    :payment_method =>  "paypal" },
  :redirect_urls => {
    :return_url => "http://localhost:3000/billings/execute",
    :cancel_url => "http://localhost:3000/" },
  :transactions =>  [{
    :item_list => {
      :items => [{
        name: 'CryptoOrb',
        sku: cart.id,
        price: @orb_current_price,
        currency: 'USD',
        quantity: cart.total_orbs
        }]},
    :amount =>  {
      :total =>  cart.paid_amount,
      :currency =>  "USD" },
    :description =>  "Billing for #{cart.paid_amount} CryptOrbs." }]})

    if payment.create
      redirect_url = payment.links.find{|v| v.method == "REDIRECT"}.href
      redirect_to redirect_url
    else
      payment.error
    end
  end

  def execute
    paypal_payment = PayPal::SDK::REST::Payment.find(params[:paymentId])

    if paypal_payment.execute(payer_id: params[:PayerID])
      new_orbs = current_player.cart.total_orbs
      amount = paypal_payment.transactions.first.amount.total
      orbs = current_player.wallet.orbs
      current_player.wallet.update(orbs: (orbs + new_orbs))
      current_player.cart.update(paid: true, code: paypal_payment.id, payment_method: 'paypal', currency: 'USD', paid_amount: amount)
      redirect_to root_path, notice: "#{new_orbs} CryptOrbs were correctly added to your account!"
    end
  end

  private

  def set_orb_price
    @orb_current_price = 1.2
  end
end
