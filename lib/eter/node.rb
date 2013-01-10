module Eter::Node
  autoload :Abstract, 'eter/node/abstract'
  autoload :Handler, 'eter/node/handler'

  def self.build(node)
    params = {}
    if eterhandler = node['eter']
      node.each do |attr, value|
        if attr =~ /^eter:(.+)$/
          params[$1] = value
          node.remove_attribute(attr)
        end
      end
      node.remove_attribute('eter')
      
      handler_name = eterhandler.split(':').join.downcase
      klass = Eter::Node::Handler.get(handler_name) || Eter::Node::Abstract
    else
      klass = Eter::Node::Abstract
    end

    klass.new(node, params)
  end

end
