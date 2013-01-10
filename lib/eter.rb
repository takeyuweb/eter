require 'eter/template'
require 'eter/context'

module Eter
  def output(source, context = {})
    Eter::Template.new(source).output(context)
  end
end

require 'eter/version'
