module Manufacture
  def add_manufacturer(manufacturer)
    @manufacturer = manufacturer
  end

  def manufacturer
    if @manufacturer
      puts '============================='
      puts "Manufacturer: #{@manufacturer}"
      puts '============================='
    else
      puts '####################################################'
      puts 'The manufacturer for this carriage has not been set!'
      puts '####################################################'
    end
  end
end
