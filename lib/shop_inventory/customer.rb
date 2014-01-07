require_relative "product"
module ShopInventory
	class Customer < Product
	  WRONG_CHOICE=-1
	  
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
		      	
		        buy
		      else
		      	choice=WRONG_CHOICE
		        puts "Wrong choice \n Please enter valid choice:!!!"
		    end
		  end while choice==WRONG_CHOICE
		end
	  
	end
end