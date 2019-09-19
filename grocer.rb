def consolidate_cart(cart)
  new_hash = {}
  cart.each do |item|
    key = item.keys[0]
    if new_hash[key]
      new_hash[key][:count] += 1
    else
      nested_hash = item[key]
      nested_hash[:count] = 1
      new_hash[key] = nested_hash
    end
  end
  new_hash
end

def apply_coupons(cart, coupons)
  new_cart = {}
  cart.each do |k, v|
    coupon = coupons.find { |coupon| coupon[:item] == k }
    original_count = v[:count]
    if_clearance = v[:clearance]
    initial_price = v[:price]

    if coupon
      number_coupons = coupons.count(coupon)
      disc_item = coupon[:item]
      qty = coupon[:num]
      total_cost = coupon[:cost]
      disc_price = total_cost / qty
      new_cart["#{disc_item} W/COUPON"] = { price: disc_price, clearance: if_clearance, count: qty*number_coupons }
      new_cart[k] = { price: initial_price, clearance: if_clearance, count: original_count - qty*number_coupons }
    else
      new_cart[k] = { price: initial_price, clearance: if_clearance, count: original_count }
    end
  end
  new_cart
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
