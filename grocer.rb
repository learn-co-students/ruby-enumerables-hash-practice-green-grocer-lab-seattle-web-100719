def consolidate_cart(cart)
  new_cart = {} 
  cart.each do |items_array| 
    items_array.each do |item, attribute_hash| 
      new_cart[item] ||= attribute_hash 
      new_cart[item][:count] ? new_cart[item][:count] += 1 :
      new_cart[item][:count] = 1 
    end 
  end 
new_cart 
end

def apply_coupons(cart, coupons)
 coupons.each do |coupon|
   item = coupon[:item]
   if cart[item] 
     if cart[item][:count] >= coupon[:num] && !cart["#{item} W/COUPON"]
       cart["#{item} W/COUPON"] = {price: coupon[:cost] / coupon[:num], clearance: cart[item][:clearance],count: coupon[:num]}
       cart[item][:count] -= coupon[:num]
     elsif cart[item][:count] >= coupon[:num] && cart["#{item} W/COUPON"]
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

def checkout(cart, coupons)
hash_cart = consolidate_cart(cart)
applied_coupons = apply_coupons(hash_cart, coupons)
applied_clearance = apply_clearance(applied_coupons)

total = applied_clearance.reduce(0) {|acc, (key, value)| acc += value[:price] * value[:count]}

total > 100 ? total * 0.9 : total
end
