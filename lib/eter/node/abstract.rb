require 'cgi'

class Eter::Node::Abstract
  attr_accessor :children, :params
  def initialize(node, params={})
    @children = []

    node.children.each do |n|
      @children << Eter::Node.build(n)
    end

    node.unlink
    @node = node
    @params = params || {}
    @deletion = @params.delete('deletion')
  end

  def html(context = nil)
    node = @node.dup(1)
    unless node.text? || node.comment?
      node.each do |attr, value|
        if attr.to_s =~ /^set:(.+)$/
          node[$1] = context[value.to_s.gsub(/\s/, '')].to_s
          node.delete(attr)
        end
      end
      context.scope do
        context.stash[:handler] = self
        context.stash[:node] = node

        node.inner_html = process(context){
          @children.map{|child| child.html(context) }.join
        }.to_s
      end
    end

    deletion? ?
      node.inner_html(save_with: Nokogiri::XML::Node::SaveOptions::AS_HTML | Nokogiri::XML::Node::SaveOptions::NO_DECLARATION) :
      node.to_xml(save_with: Nokogiri::XML::Node::SaveOptions::AS_HTML | Nokogiri::XML::Node::SaveOptions::NO_DECLARATION)
  end

  private
  def process(context, &block)
    block.call(context)
  end

  def deletion?
    @deletion
  end
end
