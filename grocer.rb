def consolidate_cart(cart)
  final_array = {}
  cart.each do |element_hash|
    element_name = element_hash.keys[0]
    element_values = element_hash.values[0]
    if final_array[element_name]
      element_values[:count] += 1
    else
      final_array[element_name] = element_values
      final_array[element_name][:count] = 1
    end
  end
  final_array
end

# def apply_coupons(cart, coupons)
#   coupons.each do |coupon|
#     item = coupon[:item]
#     if cart[item]
#       if cart[item][:count] >= coupon[:num] && !cart["#{item} W/COUPON"]
#        cart["#{item} W/COUPON"] = {price: coupon[:cost] / coupon[:num], clearance: cart[item][:clearance], count: coupon[:num]}
#       elsif cart[item][:count] >= coupon[:num] && cart["#{item} W/COUPON"]
#         cart["#{item} W/COUPON"][:count] -= coupon[:num]
#       end
#       cart[item][:count] -= coupon[:num]
#     end
#   end
#   cart
# end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item = coupon[:item]
    if cart[item]
      if cart[item][:count] >= coupon[:num] && !cart.has_key?("#{item} W/COUPON")
        cart["#{item} W/COUPON"] = {price: coupon[:cost] / coupon[:num], clearance: cart[item][:clearance], count: coupon[:num]}
        cart[item][:count] -= coupon[:num]
      elsif cart[item][:count] >= coupon[:num] && cart.has_key?("#{item} W/COUPON")
        cart["#{item} W/COUPON"][:count] += coupon[:num]
        cart[item][:count] -= coupon[:num]
      end
      end
    end

  cart
end

def apply_clearance(cart)
  cart.each do |item, price_hash|
    if price_hash[:clearance] == true
      price_hash[:price] = (price_hash[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(items, coupons)
  cart = consolidate_cart(items)
  cart1 = apply_coupons(cart, coupons)
  cart2 = apply_clearance(cart1)

  total = 0

  cart2.each do |name, price_hash|
    total += price_hash[:price] * price_hash[:count]
  end

  total > 100 ? total * 0.9 : total

end
