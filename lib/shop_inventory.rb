require_relative "shop_inventory/shop"
require_relative "shop_inventory/shopkeeper"
require_relative "shop_inventory/product"
module ShopInventory

  class ShopInventory
    def self.start
      shop=Shop.new
      shop.go_to_shop
    end
  end  
  
end