class Meth
  attr_accessor :name,:returnType,:methodType,:preExecute,:postExecute,:primaryExecute
  def initialize(options)
    @name = options.key?("name") ? options["name"] : String.new
    @returnType = options.key?("returnType") ? options["returnType"] : String.new
    @methodType = options.key?("methodType") ? options["methodType"] : String.new
    @preExecute = options.key?("preExecute") ? options["preExecute"] : Array.new
    @postExecute = options.key?("postExecute") ? options["postExecute"] : Array.new
    @primaryExecute = options.key?("primaryExecute") ? options["primaryExecute"] : Array.new
  end
  def to_json(*a)
    {"name" => @name, "returnType" => @returnType, "methodType" => @methodType, "preExecute" => @preExecute, "postExecute" => @postExecute, "primaryExecute" => @primaryExecute }.to_json(*a)
  end
  def to_hash(*a)
    {"name" => @name, "returnType" => @returnType, "methodType" => @methodType, "preExecute" => @preExecute, "postExecute" => @postExecute, "primaryExecute" => @primaryExecute }
  end

  def parseXML(doc)
    @name = doc.css("method").attr('name')
    @returnType = doc.css("method").attr('returnType')
    @methodType = doc.css("method").attr('methodType')
    @preExecute = Array.new
    @postExecute = Array.new
    @primaryExecute = Array.new
    doc.css("preExecuteTargets methodTarget").each do |method|
      meth = Hash.new
      meth["targetType"] = method.attr("targetType")
      meth["targetMethod"] = method.attr("targetMethod")
      meth["active"] = method.attr("active")
      @preExecute.push(meth)
    end
    doc.css("methodTargets methodTarget").each do |method|
      meth = Hash.new
      meth["targetType"] = method.attr("targetType")
      meth["targetMethod"] = method.attr("targetMethod")
      meth["active"] = method.attr("active")
      @primaryExecute.push(meth)
    end
    doc.css("postExecuteTargets methodTarget").each do |method|
      meth = Hash.new
      meth["targetType"] = method.attr("targetType")
      meth["targetMethod"] = method.attr("targetMethod")
      meth["active"] = method.attr("active")
      @postExecute.push(meth)
    end
  end
end
