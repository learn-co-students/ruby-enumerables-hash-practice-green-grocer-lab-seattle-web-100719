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
  total_no_items = {}

  cart.each do |k, v|
    count = v[:count]
      if total_no_items [k]
        total_no_items[k] += count
        else total_no_items[k] = count
      end
  end

    cart.each do |k, v|
    coupon = coupons.find { |coupon| coupon[:item] == k }
    if coupon
      number_coupons = coupons.count(coupon)
      disc_item = coupon[:item]
      qty = coupon[:num]
      total_cost = coupon[:cost]
      disc_price = total_cost / qty
      number_applicable_coupons = total_no_items["#{disc_item}"] / coupon[:num]

      new_cart["#{disc_item} W/COUPON"] = { price: disc_price, clearance: v[:clearance], count: number_applicable_coupons*qty }
      new_cart[k] = { price: v[:price], clearance: v[:clearance], count: v[:count] - number_applicable_coupons*qty }
    else
      new_cart[k] = { price: v[:price], clearance: v[:clearance], count: v[:count] }
    end
    end
  new_cart
end

def apply_clearance(cart)
    new_cart = {}
  cart.each do |k, v|
    discount = (v[:price] * 0.20).round(2)
    if v[:clearance]
      new_cart[k] = { price: v[:price] - discount, clearance: v[:clearance], count: v[:count] }
    else
      new_cart[k] = v 
    end
  end
  new_cart
end

def checkout(cart, coupons)
  total = 0

  new_cart = consolidate_cart(cart)
  cart_with_coupons = apply_coupons(new_cart, coupons)
  cart_with_clearance = apply_clearance(cart_with_coupons)

  cart_with_clearance.each do |k, v|
    total += v[:price] * v[:count]
  end

  total > 100 ? total * 0.9 :total
end
