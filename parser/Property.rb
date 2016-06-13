class Property
  attr_accessor :name,:tableName,:audited,:isReadOnly,:columnName
  def initialize(options)
    @name = options.key?("name") ? options["name"] : String.new
    @tableName = options.key?("tableName") ? options["tableName"] : String.new
    @audited = options.key?("audited") ? options["audited"] : String.new
    @isReadOnly = options.key?("isReadOnly") ? options["isReadOnly"] : String.new
    @columnName = options.key?("columnName") ? options["columnName"] : String.new
  end
  def to_json(*a)
    {"name" => @name, "tableName" => @tableName, "audited" => @audited, "isReadOnly" => @isReadOnly, "columnName" => @columnName }.to_json(*a)
  end
  def to_hash(*a)
    {"name" => @name, "tableName" => @tableName, "audited" => @audited, "isReadOnly" => @isReadOnly, "columnName" => @columnName }
  end

  def parseXML(doc,tableName)
    @name = doc.attr('name')
    @audited = doc.attr('audited')
    @isReadOnly = doc.attr('isReadOnly')
    @columnName = doc.attr('columnName')
    @tableName = tableName
  end
end
