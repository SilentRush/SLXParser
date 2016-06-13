class Filter
  attr_accessor :name,:type,:propertyName
  def initialize(options)
    @name = options.key?("name") ? options["name"] : String.new
    @type  = options.key?("type") ? options["type"] : String.new
    @propertyName  = options.key?("propertyName") ? options["propertyName"] : String.new
  end
  def to_json(*a)
    {"name" => @name, "type" => @type, "propertyName" => @propertyName }.to_json(*a)
  end
  def to_hash(*a)
    {"name" => @name, "type" => @type, "propertyName" => @propertyName }
  end

  def parseXML(doc)
    @name = doc.css("entityFilter").attr('filterName')
    @type = doc.css("entityFilter").attr('type')
    @propertyName = doc.css("entityFilter").attr('propertyName')
  end
end
