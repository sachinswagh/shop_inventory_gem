require 'fileutils'
require_relative 'product'
#require 'shop'
#require 'customer'
module ShopInventory
  class Shopkeeper < Product
    WRONG_CHOICE=-1

    def choices_to_shopkeeper

      begin
        print "\n\n\tMENU \n\n1.Add Product \n2.Remove Product"
        print "\n3.View List of Products \n4.Search Product \n5.Edit product details"
        print "\n\nEnter your choice: "
        choice = gets
        shop=Shop.new
        case choice.to_i
        when 1
          begin
            id=shop.get_max_product_id
            id+=1
            product_details=shop.ask_product_details(id)
            add_product(product_details)
            list_all_products
            print "\n\nDo you want to add more products(y/n): "
            choice=gets
          end while(choice.casecmp("y\n")==0)
        when 2
          print "\n\nEnter id of the product to be removed: "
          id_to_be_removed=gets
          remove_product(id_to_be_removed.to_i)
          list_all_products
        when 3
          list_all_products
        when 4
          ask_details_and_search
        when 5
          print "\n\nEnter id of the product to be edited: "
          id_to_be_edited=gets
          edit(id_to_be_edited.to_i,true,0)
          puts "\nAfter editing list of products is: "
          list_all_products
        else
          choice=WRONG_CHOICE
          puts "Wrong choice !!!"
        end
      end while choice==WRONG_CHOICE
    end

    def add_product(product_details)
      record=""
      product_details.each do |product_attribute|
        product_attribute.to_s
        product_attribute.chomp!
        record.concat("#{product_attribute},")
      end
      
      File.open(File.expand_path('inventory.txt', File.dirname(__FILE__)), "a+") do |f|
        if f
          record.chop!
          record.concat("\n")
          f.syswrite(record)
        else
          puts "Unable to open #{f} file!"
        end 
        f.close
      end 	
    end

    def remove_product(id_to_be_removed)
      temp_path=File.expand_path('temp_file.txt', File.dirname(__FILE__))
      inventory_path=File.expand_path('inventory.txt', File.dirname(__FILE__))

      list=Array[]                 
      File.open(inventory_path, "r") do |file_name|
        if file_name
          list = IO.readlines(file_name)   			
        else
          puts "Unable to open file!"
        end
      end
      File.open(temp_path, "w") do |temp_file|
        list.each do |record|
          attributes=record.split(",")
          if id_to_be_removed!=attributes[0].to_i
            temp_file.syswrite(record)
          else
            puts "\nProduct:   #{attributes[1]} Removed .................."            
          end
        end
      end  
      
      FileUtils.mv("#{temp_path}","#{inventory_path}")
    end

    def edit(id_to_be_edited, edit_request, remove_no_items)
      inventory_path=File.expand_path('inventory.txt', File.dirname(__FILE__))
      temp_path=File.expand_path('temp_file.txt', File.dirname(__FILE__))

      list=Array[]       
      File.open(inventory_path, "r") do |file_name|
        if file_name
          list = IO.readlines(file_name)        
        else
          puts "Unable to open file!"
        end
      end
      
      File.open(temp_path, "w") do |temp_file|
        list.each do |record|
          attributes=record.split(",")
          if id_to_be_edited!=attributes[0].to_i
            temp_file.syswrite(record)
          else
            shop=Shop.new
            if edit_request
              puts "\nLets edit details of the product with id= #{id_to_be_edited}: "
              product_details=shop.ask_product_details(id_to_be_edited)
            else
              product_details=attributes
              product_details[3]=product_details[3].to_i- remove_no_items.to_i
              product_details[3].to_s
            end
            record=""
            product_details.each do |product_attribute|
              product_attribute.to_s
              product_attribute.chomp! if edit_request
              record.concat("#{product_attribute},")
            end
            record.chop!
            record.concat("\n") if edit_request
            temp_file.syswrite(record)
            
          end
        end
      end
      
      FileUtils.mv(File.expand_path('temp_file.txt', File.dirname(__FILE__)),File.expand_path('inventory.txt', File.dirname(__FILE__)))  
    end
  end 
  shop=Shop.new
  shop.go_to_shop
end