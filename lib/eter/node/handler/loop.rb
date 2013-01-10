class Eter::Node::Handler::Loop < Eter::Node::Handler
  
  def process(context, &block)
    vars = context[params['name'].to_sym] || []
    case vars
    when Hash
      counter = 0
      vars.map{ |key, value|
        context[:__key__] = key
        context[:__value__] = value
        context[:__counter__] = counter
        ret = block.call(context)
        counter = counter.succ
        ret
      }.join
    else
      counter = 0
      vars.map{ |value|
        context[:__value__] = value
        context[:__counter__] = counter
        ret = block.call(context)
        counter = counter.succ
        ret
      }.join
    end
  end

end
