require 'nokogiri'

require 'eter/node'

class Eter::Template
  attr_reader :source, :nodes

  def initialize(source)
    @source = source

    fragment = Nokogiri::HTML.fragment(source)
    @nodes = fragment.children.map{ |node| Eter::Node.build(node) }
  end

  def output(context = Eter::Context.new)
    context = Eter::Context.new(context) unless context.kind_of?(Eter::Context)
    @nodes.map{ |node| node.html(context) }.join
  end
end
