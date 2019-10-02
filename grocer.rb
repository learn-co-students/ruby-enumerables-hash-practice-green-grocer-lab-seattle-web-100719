def consolidate_cart(cart)
  # code here
  new_cart ={}
  i = 0
  while cart[i] do
   count_items= (cart.find_all {|item| item.keys == cart[i].keys}).count
   
   new_cart.merge!(cart[i])
   new_cart[cart[i].keys[0]][:count]= count_items
   i += 1
 end
  new_cart 
end


def apply_coupons(cart, coupons)
  i=0
  applyed_coupons_cart={}
  if coupons==[]
    coupons=[{:item => ""}]
  end
  
  while i<coupons.size do
    cart.each_key do |key| 
        item_count=cart[key][:count]
        (puts cart[key][:count]= item_count % (coupons[i][:num])
        applyed_coupons_cart[key]=cart[key]
        applyed_coupons_cart[key+" W/COUPON"]={}
        applyed_coupons_cart[key+" W/COUPON"]=applyed_coupons_cart[key+" W/COUPON"].merge(cart[key])
        applyed_coupons_cart[key+" W/COUPON"][:price]=(coupons[i][:cost]/coupons[i][:num])
        applyed_coupons_cart[key+" W/COUPON"][:count]= item_count-cart[key][:count] 
        applyed_coupons_cart[key+" W/COUPON"]) if key == coupons[i][:item] && item_count >= coupons[i][:num]
        applyed_coupons_cart[key]=cart[key] if coupons==[0] || key != coupons[i][:item] || item_count < coupons[i][:num]
    end
    i += 1
  end
  applyed_coupons_cart
end



def apply_clearance(cart)
  # code here
  cart.each_key do |key|
    cart[key][:price] =  ((cart[key][:price])*(0.8)).round(2) if cart[key][:clearance] == true
  end
    
end

def checkout(cart, coupons)
  # code here
  total=0
  checkout_cart={}
  checkout_cart=consolidate_cart(cart)
  checkout_cart=apply_coupons(checkout_cart,coupons)
  checkout_cart=apply_clearance(checkout_cart)
  checkout_cart.each_key do |key|
      puts total+= (checkout_cart[key][:price])*(checkout_cart[key][:count])
      end
  last_total=total    
  last_total=total*(0.9) if total>100
  last_total
end
