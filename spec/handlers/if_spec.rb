# -*- coding: utf-8 -*-
require 'spec_helper'

describe Eter::Node::Handler::If do

  it "条件分岐できること" do
    tmpl = Eter::Template.new('<div eter="if" eter:name="val1">1</div><div eter="if" eter:name="val2">2</div>')
    tmpl.output(val2: 1).should == '<div>2</div>'
  end

end
