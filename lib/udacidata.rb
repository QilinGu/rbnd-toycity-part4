require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  # Your code goes here!
  create_finder_methods(:name, :brand)
  @@data_path = File.dirname(__FILE__) + "/../data/data.csv"
  def self.create(options={})
  	products = []
  	product=self.new(options)
  	self.add_to_database(product)
  	products << product
  	return product
  end
  def self.all
  	products = []
  	data = CSV.read(@@data_path).drop(1)
  	data.each do |row|
  		products << self.new(id: row[0], brand: row[1], name: row[2], price: row[3])
  	end
  	return products
  end

  def self.first(n=1)
  	n == 1? self.all.first : self.all.take(n)
  end

  def self.last(n=1)
    n == 1? self.all.last : self.all.last(n)
  end

  def self.find(n)
    result = self.all.select {|product| product.id == n}
    if result.empty?
      raise ProductNotFoundError
    else
      return result[0]
    end
  end

  def self.destroy(n)
    product = self.find(n)
    products = self.all
    products.delete_if {|product| product.id == n}
    CSV.open(@@data_path, "wb") do |csv|
      csv <<  ["id", "brand", "product", "price"]
      products.each do |product|
        csv << [product.id, product.brand, product.name, product.price]
      end
    end
    return product
  end

  def self.where(options={})
    result = []
    options.each do |key, value|
      result << self.all.select {|product| product.send(key) == value}
    end
    result.length == 1? result.first : result
  end

  def update(options={})
    products = self.class.all
    index_to_update = products.index{|item| item.id == @id}
    product = products[index_to_update]
    options.each do |key, value|
      product.send("#{key}=", value)
    end
    
    CSV.open(@@data_path, "wb") do |csv|
      csv <<  ["id", "brand", "product", "price"]
      products.each do |product|
        csv << [product.id, product.brand, product.name, product.price.to_f]
      end
    end
    return product
  end

  def self.add_to_database(product)
  	CSV.open @@data_path, "ab" do |csv|
  		csv << [product.id, product.brand, product.name, product.price]
  	end
  end
end
