require 'bigdecimal'

def calulate_discounted_prices(products)
  products = JSON.parse(products, symbolize_names: true)
  products[:products].each do |product|
    product[:price] = BigDecimal(product[:price].to_s)
    # if price < 10 then 5% discount
    # if 10 <= price <= 50  then 10% discount
    # if price > 50 then 20% discount
    if 10 <= product[:price] && product[:price] <= 50
      # 10% discount
      # require 'pry'; binding.pry
      price = (product[:price] * 0.9)
      product[:price] = price.to_f.round(2)
    end
  end
  products.to_json
end