require 'eter/node/abstract'

class Eter::Node::Handler < Eter::Node::Abstract
  autoload :Var,  'eter/node/handler/var'
  autoload :Loop, 'eter/node/handler/loop'
  autoload :If,   'eter/node/handler/if'

  class << self
    @@registry = {}

    def get(tagname)
      tagname = tagname.to_s.downcase
      klass = @@registry[tagname]
      return klass if klass
      class_name = tagname.capitalize
      if Eter::Node::Handler.const_defined?(class_name)
        klass = set(tagname, Eter::Node::Handler.const_get(class_name))
      end
      return klass
    end

    def set(tagname, klass)
      @@registry[tagname.to_s.downcase] = klass
    end
  end

end
