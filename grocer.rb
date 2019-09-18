require 'pry'

def consolidate_cart(cart)
  final_hash = {}
  cart.each do |element_hash|
    element_name = element_hash.keys[0]

    if final_hash.has_key?(element_name)
      final_hash[element_name][:count] += 1
    else
      final_hash[element_name] = {
        count: 1,
        price: element_hash[element_name][:price],
        clearance: element_hash[element_name][:clearance]
      }
    end
  end
  final_hash
end

#def apply_coupons(cart, coupons)
#  coupons.each do |coupon|
#    item = coupon[:item]
#    coupon_item = "#{item} W/COUPON"
#    if cart.has_key?(item)
#      if cart[item][:count] >= coupon[:num]
#        if !cart.has_key?(coupon_item)
#          cart[coupon_item] = {
#            price: coupon[:cost] / coupon[:num],
#            clearance: cart[item][:clearance],
#            count: coupon[:num]
#          }
#        else cart.has_key?(coupon_item)
#          cart[coupon_item][:count] += coupon[:num]
#        end
#        cart[item][:count] -= coupon[:num]
#      end
#    end
#  end
#  cart
#end

def apply_coupons(cart, coupons)
  coupons.each do |element|
    food = element[:item]

    if cart[food]
      if cart[food][:count] >= element[:num]
        if !cart.has_key?("#{food} W/COUPON")
          cart["#{food} W/COUPON"] = {:price => element[:cost]/element[:num], :clearance => cart[food][:clearance], :count => element[:num]}

          cart[food][:count] -= element[:num]

        else cart.has_key?("#{food} W/COUPON")
          cart["#{food} W/COUPON"][:count] += element[:num]
          cart[food][:count] -= element[:num]

        end
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |product_name, stats|
    if stats[:clearance]
      stats[:price] -= stats[:price] * 0.2
    end
  end
  cart
end

def checkout(cart, coupons)
  hash_cart = consolidate_cart(cart)
  applied_coupons = apply_coupons(hash_cart, coupons)
  applied_discount = apply_clearance(applied_coupons)

  total = applied_discount.reduce(0) do |acc, (key, value)|
    acc += value[:count] * value[:price]
  end
  total > 100 ? total * 0.9 : total
end

#def consolidate_cart(cart)
  #consolidated_hash = {}
  #cart.each do |item|
    #key = item.keys[0]
    #if not consolidated_hash.has_key?(key)
      #consolidated_hash[key] = item[key]
      #consolidated_hash[key][:count] = 1
    #else
      #consolidated_hash[key][:count] += 1
    #end
  #end
  #consolidated_hash
#end
