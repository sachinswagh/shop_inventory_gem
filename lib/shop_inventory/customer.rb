require_relative "product"
module ShopInventory
	class Customer < Product
	  WRONG_CHOICE=-1
	  def ask_order_details
	  	print "\n Enter id of product that you want to buy: "
	  	product_id=gets

	  	print "\n Enter your name: "
	  	cust_name=gets

	  	print "\n Enter your credit card number: "
	  	card_no=gets

	  	print "\n Enter CVV number: "
	  	cvv_no=gets
			return [product_id,cust_name,card_no,cvv_no]
	  end
	  def choices_to_customer
	  	begin
		    print "\n\n\tMENU"
		    print "\n\n1.View List of Products \n2.Search Product \n3.Buy Product"
		    print "\n\nEnter your choice: "
		    choice = gets
		    case choice.to_i
		      when 1
		        list_all_products
		      when 2
		  			ask_details_and_search
		      when 3
		      	order_details=ask_order_details
		      	store_order(order_details)
		        buy(order_details)
		      else
		      	choice=WRONG_CHOICE
		        puts "Wrong choice \n Please enter valid choice:!!!"
		    end
		  end while choice==WRONG_CHOICE
		end
	  
	end
end