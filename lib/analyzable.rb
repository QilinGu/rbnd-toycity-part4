require 'colorize'

module Analyzable
  # Your code goes here!
  def average_price(products)
  	sum = 0
  	products.each do |product|
  	  sum += product.price.to_f
  	end
  	return (sum/products.length).round(2)
  end

  def print_report(products)
  	avg_price = average_price(products)
  	brands = count_by_brand(products)
  	names = count_by_name(products)

  	report = "Inventory Report\n".light_yellow
  	report << "\n"
  	report << "Average Price: #{average_price(products)}\n".light_magenta
  	report << "Product Counts By Brand\n".light_blue
  	brands.each do |brand, count|
  	  report << "* #{brand}: #{count}\n"
  	end
  	report << "\n"
  	report << "Product Counts By Name\n".light_green
  	names.each do |name, count|
  	  report << "* #{name}: #{count}\n"
  	end
  	report << "\n"
  	report << "End of Report\n".light_yellow

  	puts report
  	return report
  end

  def count_by_brand(products)
  	brands = Hash.new(0)
  	products.each do |product|
  	  brands[product.brand] += 1
  	end
  	return brands
  end

  def count_by_name(products)
  	names = Hash.new(0)
  	products.each do |product|
  	  names[product.name] += 1
  	end
  	return names
  end
end
