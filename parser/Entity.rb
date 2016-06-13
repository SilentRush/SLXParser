require './Quickform'
require './Filter'
require './Meth'
require './Property'
class Entity
  attr_accessor :name,:quickforms,:methods,:filters,:properties
  def initialize(options)
    @name = options.key?("name") ? options["name"] : nil
    @quickforms = options.key?("quickforms") ? options["quickforms"] : Array.new
    @methods = options.key?("methods") ? options["methods"] : Array.new
    @filters = options.key?("filters") ? options["filters"] : Array.new
    @properties = options.key?("properties") ? options["properties"] : Array.new
  end

  def to_json(*a)
    {"name" => @name, "quickforms" => @quickforms, "methods" => @methods, "filters" => @filters, "properties" => @properties }.to_json(*a)
  end
  def to_hash(*a)
    {"name" => @name, "quickforms" => @quickforms, "methods" => @methods, "filters" => @filters, "properties" => @properties }
  end
end
