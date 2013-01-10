class Eter::Node::Handler::If < Eter::Node::Handler
  
  def process(context, &block)
    var = context[params['name']]
    ret = ''
    if var
      ret = block.call(context)
    else
      @deletion = true
    end
    ret
  end

end
