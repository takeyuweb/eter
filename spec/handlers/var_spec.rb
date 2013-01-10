# -*- coding: utf-8 -*-
require 'spec_helper'

describe Eter::Node::Handler::Var do

  it "変数を埋め込むこと" do
    tmpl = Eter::Template.new('<b eter="var" eter:name="hello">DUMMY</b>')
    tmpl.output(hello: 'Hello World!!').should == '<b>Hello World!!</b>'
  end

  it "存在しない変数を空として扱うこと" do
    tmpl = Eter::Template.new('<b eter="var" eter:name="hello">DUMMY</b>')
    tmpl.output.should == '<b></b>'
  end

  describe "変数操作" do
    it "+で整数を加算" do
      tmpl = Eter::Template.new('<span eter="var" eter:name="i" eter:op="+" eter:value="100"></span><b eter="var" eter:name="i">VALUE</v>')
      tmpl.output(i: 1).should == '<b>101</b>'
    end

    it "+でオペランドが実数であれば実数として加算すること" do
      tmpl = Eter::Template.new('<span eter="var" eter:name="i" eter:op="+" eter:value="0.1"></span><b eter="var" eter:name="i">VALUE</b>')
      tmpl.output(i: 100).should == '<b>100.1</b>'
    end

    it "+で現在の値が実数であれば実数として加算すること" do
      tmpl = Eter::Template.new('<span eter="var" eter:name="i" eter:op="+" eter:value="100"></span><b eter="var" eter:name="i">VALUE</b>')
      tmpl.output(i: 0.1).should == '<b>100.1</b>'
    end

  end

  it "eter:escape='html'でHTMLエスケープすること" do
    tmpl = Eter::Template.new('<h1 eter="VAR" eter:name="hello" eter:escape="html">DUMMY</h1><p>こんにちは、世界</p>')
    tmpl.output(hello: '<Hello World!!>').should == '<h1>&lt;Hello World!!&gt;</h1><p>こんにちは、世界</p>'
  end

end
