def consolidate_cart(cart)
  #get all the unique and turn it into a hash
  #map through the unique hash and add a new key -----
            # ---- called count and return the number of occurrences of each key in cart
 uniqueList = cart.uniq.reduce({}, :update)
 updatedCart = uniqueList.reduce({}) do |memo, (key, value)|
   numOfOccurrences = cart.count(key[value])
   key[value][count] = numOfOccurrences
 end

 return cartHash
end

def apply_coupons(cart, coupons)
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
