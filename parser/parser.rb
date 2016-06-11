require 'nokogiri'
require 'json'
require './Entity'
require './ParserFunctions'
account = Entity.new({})
account.name = "Account"

Dir.foreach("Account") do |item|
  if(File.file?("Account\\" + item) && item.end_with?("filter.xml"))
    doc = File.open("Account\\" + item) { |f| Nokogiri::XML(f) }
    filter = Filter.new({})
    filter.parseXML(doc)
    account.filters.push(filter)
  end
  if(File.file?("Account\\" + item) && item.end_with?("entity.xml"))
    doc = File.open("Account\\" + item) { |f| Nokogiri::XML(f) }
    doc.css("properties property").each do |property|
      prop = Property.new({})
      prop.parseXML(property, doc.css("entity").attr("tableName"))
      account.properties.push(prop)
    end
  end
  if(File.file?("Account\\" + item) && item.end_with?("method.xml"))
    doc = File.open("Account\\" + item) { |f| Nokogiri::XML(f) }
    method = Meth.new({})
    method.parseXML(doc)
    account.methods.push(method)
  end
  if(File.directory?("Account\\" + item) && item.end_with?("QuickForms"))
    Dir.foreach("Account\\" + item) do |quick|
      if(File.file?("Account\\" + item + "\\" + quick) && quick.end_with?("quickform.xml"))
        doc = File.open("Account\\" + item + "\\" + quick) { |f| Nokogiri::XML(f) }
        quickform = Quickform.new({})
        quickform.parseXML(doc)
        account.quickforms.push(quickform)
      end
    end
  end
end



json = account.to_json
f = File.new("output.json", "w")
f.puts JSON.pretty_generate(JSON.parse(json))
#f.puts json

hash1 = {'a' => 1, 'b' => "bob"}
hash2 = {'a' => 1, 'b' => 3}

#puts account.quickforms.map{|x| x.name}
#puts account.quickforms[0].loadactions.map{|x| x["MethodName"]} - account.quickforms[1].loadactions.map{|x| x["MethodName"]}

#puts Hash[*(account.quickforms[0].loadactions - account.quickforms[1].loadactions).flatten]
