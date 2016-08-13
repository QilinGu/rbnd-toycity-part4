class Module
  def create_finder_methods(*attributes)
    # Your code goes here!
    # Hint: Remember attr_reader and class_eval
    attributes.each do |attribute|
    	method = %Q(
    	def self.find_by_#{attribute.to_s}(value)
    		result = self.all.select {|product| product.#{attribute.to_s} == value.to_s}
    		if result
    			return result.first
    		else
    			return nil
    		end
    	end
    	)
    	self.class_eval(method)
    end
  end
end
