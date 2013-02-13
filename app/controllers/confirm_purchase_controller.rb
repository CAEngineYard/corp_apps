class ConfirmPurchaseController < ApplicationController
  def show
    @cart = current_cart
  end
  def customerPost
      # saveUser()
  #  purchaseProducts()
    @cart = current_cart
    @cart.destroy
    session[:cart_id] = nil
      redirect_to :controller => 'products',:action => 'index'
  end
  def purchaseProducts
    email = params[:Email]
    account_did = params[:AccountDID]
    sales_rep_id = 'INDEPENDENT'
    caws_product = []
    caws_product[0] = {
              'ProductID' => 'FPJOBLOGID'
    }
    caws_product[1] ={
        'ProductID' => 'FRPRI100'
    }
    #@products = {'CAWSProduct' => caws_product}

    @products = {['Products']['CAWSProduct'] => caws_product }
    partner_group_id = 'N3SH7C76LM1NYDND654'
    partner_rep_id = 'NR7I7LJ6HYT5DG8HT5PK'
    payment_method = 'INV'
    client = Savon::Client.new(wsdl: 'http://nexustest.careerbuilder.com/webservices/purchasing.asmx?wsdl')
    response = client.call( :purchase_products , message: {'PartnerID' => 'Nexus','PartnerPassword' => 'R3S3LL3R',
                                                           'AccountDID' => account_did,
                                                          'UserEmail' => email,
                                                          'PaymentMethod' => payment_method,
                                                          'SalesRepID' => sales_rep_id  ,
                                                          'PartnerGroupID' => partner_group_id,
                                                          'PartnerRepID' => partner_rep_id,
                                                          'Products' => @products  })
    response_text = response.body[:purchase_products_result]



  end

end
