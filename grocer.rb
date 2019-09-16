def consolidate_cart(cart)
  # code here
  consolidated = {}
  cart.each do |item| 
    key = item.keys[0]
    if not consolidated.has_key?(key)
      consolidated[key] = item[key]
      consolidated[key][:count] = 1
    else
      consolidated[key][:count] += 1 
    end
  end
  return consolidated
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    food = coupon[:item]
    if cart[food] and coupon[:num] <= cart[food][:count]
      cart[food][:count] -= coupon[:num]
      
      if not cart["#{food} W/COUPON"]
        cart["#{food} W/COUPON"] = {price: coupon[:cost]/coupon[:num], clearance: cart[food][:clearance], count: coupon[:num]}
      else
        cart["#{food} W/COUPON"][:count] += coupon[:num]
      end
    end
  end
  return cart
end

def apply_clearance(cart)
  # code here
  cart.keys.each do |key|
    if cart[key][:clearance]
      cart[key][:price] = (0.8*cart[key][:price]).round(2)
    end
  end
  return cart
end

def checkout(cart, coupons)
  # code here
  consol = consolidate_cart(cart)
  
  coup = apply_coupons(consol, coupons)
  
  clear = apply_clearance(coup)
  
  total = 0 
  
  clear.keys.each do |key|
    total += clear[key][:price]*clear[key][:count]
  end
  
  if total >= 100
    total = (total*0.9).round(2)
  end
  return total
end
