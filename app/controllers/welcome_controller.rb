class WelcomeController < ApplicationController

  def index
  	@products = Product.order(created_at: :desc).limit(12)
    @sale = Sale.where("start_date <= ? and end_date >= ?", Date.today, Date.today).first
    #SELECT  "sales".* FROM "sales" WHERE (start_date <= '2016-06-20' and end_date >= '2016-06-20')  ORDER BY "sales"."id" DESC LIMIT 1
    @sales_products = @sale.products if @sale.present?
  end
  

  def search
 	  if params[:search].present?
      @products = Product.where("LOWER(name) LIKE ?" , "%#{params[:search]}%").order("created_at DESC")
    else
      @products = Product.all.order("created_at DESC")
    end
      render 'index'
  end
end




