class Quickform
  attr_accessor :name,:entity_type,:loadactions,:controls,:columns,:rows
  def initialize(options)
    @name = options.key?("name") ? options["name"] : nil
    @entity_type = options.key?("entity_type") ? options["entity_type"] : nil
    @loadactions = options.key?("loadactions") ? options["loadactions"] : Array.new
    @controls = options.key?("controls") ? options["controls"] : Array.new
    @columns = options.key?("columns") ? options["columns"] : Array.new
    @rows = options.key?("rows") ? options["rows"] : Array.new
  end
  def to_json(*a)
    {"name" => @name, "entity_type" => @entity_type, "loadactions" => @loadactions, "controls" => @controls, "columns" => @columns, "rows" => @rows }.to_json(*a)
  end
  def to_hash(*a)
    {"name" => @name, "entity_type" => @entity_type, "loadactions" => @loadactions, "controls" => @controls, "columns" => @columns, "rows" => @rows }
  end

  def parseXML(doc)
    @loadactions = Array.new
    @controls = Array.new
    @name = doc.css("Name").first.text if (doc.css("Name").length > 0)
    @entity_type = doc.css("EntityTypeName").text
    @rows = doc.css("Rows RowStyle").length
    @columns = doc.css("Columns ColumnStyle").length
    doc.css("LoadActions FormActionDefinition").each do |loadAction|
      lhash = Hash.new
      lhash["type"] = /[^,]+/.match(loadAction.css("Action").attr('typeName')) if(loadAction.css("Action").length > 0)
      lhash["MethodName"] = loadAction.css("MethodName").text if(loadAction.css("MethodName").length > 0)
      lhash["CSharpCodeSnippet"] = loadAction.css("CSharpCodeSnippet").text if(loadAction.css("CSharpCodeSnippet").length > 0)
      @loadactions.push(lhash)
    end

    controls = doc.css("Control").each do |control|
      chash = Hash.new
      if(!control.attr('typeName').nil?)
        chash["type"] = /[^,]+/.match(control.attr('typeName')).to_s
      else
        chash["type"] = /[^,]+/.match(control.attr('TypeName')).to_s
      end
      chash["type"].slice!("Controls.")
      chash["DataSourceID"] = control.css("DataSourceID").first.text if(control.css("DataSourceID").length > 0)
      chash["DataItemName"] = control.css("DataItemName").first.text if(control.css("DataItemName").length > 0)
      chash["ControlId"] = control.css("ControlId").first.text if(control.css("ControlId").length > 0)
      chash["Required"] = control.css("Required").first.text if(control.css("Required").length > 0)
      chash["Visible"] = control.css("Visible").first.text if(control.css("Visible").length > 0)
      chash["OnChangeAction"] = Array.new
      chash["OnClientClick"] = Array.new
      chash["OnClickAction"] = Array.new
      if(control.css("OnChangeAction").length > 0)
        control.css("OnChangeAction").each do |onchange|
          changeAction = Hash.new
          changeAction["ResourceKey"] = onchange.css("ResourceKey").first.text if(onchange.css("ResourceKey").length > 0)
          changeAction["MethodName"] = onchange.css("CSharpSnippetActionItem MethodName").first.text if(onchange.css("CSharpSnippetActionItem MethodName").length > 0)
          changeAction["CSharpCodeSnippet"] = onchange.css("CSharpSnippetActionItem CSharpCodeSnippet").first.text if(onchange.css("CSharpSnippetActionItem CSharpCodeSnippet").length > 0)
          chash["OnChangeAction"].push(changeAction)
        end
      end
      if(control.css("OnClickAction").length > 0)
        control.css("OnChangeAction").each do |onchange|
          onClickAction = Hash.new
          onClickAction["MethodName"] = onchange.css("MethodName").first.text if(onchange.css("MethodName").length > 0)
          onClickAction["ResourceKey"] = onchange.css("ResourceKey").first.text if(onchange.css("ResourceKey").length > 0)
          chash["OnClickAction"].push(onClickAction)
        end
      end
      chash["Row"] = control.css("Row").first.text
      chash["Column"] = control.css("Column").first.text
      @controls.push(chash)
    end
  end
end
