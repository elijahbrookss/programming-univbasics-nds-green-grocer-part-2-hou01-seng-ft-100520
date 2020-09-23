require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  if coupons.length > 0 then
    new_cart = [];
    cart.each do |item|
      coupons.each do |coupons_item|
        if item[:item] == coupons_item[:item] then
          if item[:count] >= coupons_item[:num] then
            item[:count] -= coupons_item[:num];
            new_cart.push({
              :item => item[:item],
              :price => item[:price],
              :clearance => item[:clearance],
              :count => item[:count]
            })
            new_cart.push({
              :item => "#{item[:item]} W/COUPON",
              :price => coupons_item[:cost]/coupons_item[:num],
              :clearance => item[:clearance],
              :count => coupons_item[:num]
            })
          else
            item[:count] = 0;
            new_cart.push({
              :item => "#{item[:item]} W/COUPON",
              :price => coupons_item[:cost]/coupons_item[:num],
              :clearance => item[:clearance],
              :count => coupons_item[:num]
            })
          end
        else
          new_cart.push(item);
        end
      end
    end
    return new_cart
  end
  return cart
end
  
def apply_clearance(cart)
  cart.each{
    |item|
    if item[:clearance] then
      new_price = (item[:price] * 8/10).round(2);
      item[:price] = new_price
    end
  }
end


def checkout(cart, coupons)
  total = 0;
  consolidated_cart = consolidate_cart(cart);
  couponds_applied_cart = apply_coupons(consolidated_cart, consolidate_cart(coupons))
  final_cart = apply_clearance(couponds_applied_cart);
  final_cart.each {|item| total += item[:price] * item[:count]};
  
  if total > 100 then
    total = total * 9/10
  end

  return total
end

p checkout([{:item=>"SOY MILK", :price=>4.5, :clearance=>true}, {:item=>"AVOCADO", :price=>3.0, :clearance=>true}, {:item=>"AVOCADO", :price=>3.0, :clearance=>true}, {:item=>"CHEESE", :price=>6.5, :clearance=>false}, {:item=>"CHEESE", :price=>6.5, :clearance=>false}, {:item=>"CHEESE", :price=>6.5, :clearance=>false}], [{:item=>"AVOCADO", :num=>2, :cost=>5.0}, {:item=>"CHEESE", :num=>3, :cost=>15.0}])
