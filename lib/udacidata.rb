require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  # Your code goes here! 
  @@data_path = File.dirname(__FILE__) + "/../data/data.csv"
  def self.create(options={})
  	@@products = []
  	product=new(options)
  	add_to_database(product)
  	@@products << product
  	return product
  end
  def self.all
  	@@products = []
  	data = CSV.read(@@data_path).drop(1)
  	data.each do |row|
  		@@products << self.new(id: row[0], brand: row[1], name: row[2], price: row[4])
  	end
  	return @@products
  end

  def self.add_to_database *products
  	CSV.open @@data_path, "ab" do |csv|
  		products.each do |product|
  			csv << [product.id, product.brand, product.name, product.price]
  		end
  	end
  end
end
