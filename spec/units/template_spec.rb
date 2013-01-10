# -*- coding: utf-8 -*-
require 'spec_helper'

describe Eter::Template, "#output" do

  it "テキストノードのみ" do
    tmpl = Eter::Template.new('Hello World!!')
    tmpl.output.should == 'Hello World!!'
  end

  it "コメントを含む場合に処理できること" do
    tmpl = Eter::Template.new('<!-- コメント --><h1 eter="var" eter:name="hello">DUMMY</h1><p>こんにちは、世界</p>')
    tmpl.output(hello: 'Hello World!!').should == '<!-- コメント --><h1>Hello World!!</h1><p>こんにちは、世界</p>'
  end

  it "属性表記を処理できること" do
    tmpl = Eter::Template.new('<h1 eter="var" eter:name="hello">DUMMY</h1><p>こんにちは、世界</p>')
    tmpl.output(hello: 'Hello World!!').should == '<h1>Hello World!!</h1><p>こんにちは、世界</p>'
  end

  it "ネスト構造を処理できること" do
    tmpl = Eter::Template.new(<<'TMPL')
    <dl eter="loop" eter:name="items">
        <dt><span class="name" eter="var" eter:name="__key__">DUMMY_KEY</span></dt>
        <dd><span class="description" eter="var" eter:name="__value__">DUMMY_VALUE</span></dd>
    </dl>
TMPL
    tmpl.output(items: {Apple: 'りんご', Orange: 'みかん', Banana: 'バナナ'}).gsub(/\s{2,}/m, '').chomp.should == <<'HTML'.gsub(/\s{2,}/m, '').chomp
    <dl>
        <dt><span class="name">Apple</span></dt>
        <dd><span class="description">りんご</span></dd>
        <dt><span class="name">Orange</span></dt>
        <dd><span class="description">みかん</span></dd>
        <dt><span class="name">Banana</span></dt>
        <dd><span class="description">バナナ</span></dd>
    </dl>
HTML
  end

  it "表記揺れを処理できること" do
    tmpl = Eter::Template.new('<h1 eter="VAR" eter:name="hello">DUMMY</h1><p>こんにちは、世界</p>')
    tmpl.output(hello: 'Hello World!!').should == '<h1>Hello World!!</h1><p>こんにちは、世界</p>'
  end

  it 'set:attr_name="value_name" で属性値に変数の値をセットできること' do
    tmpl = Eter::Template.new('<ul eter="loop" eter:name="links"><li><a href="#dummy" set:href="__value__.href" title="dummy" set:title="__value__.title">Link</a></li></ul>')
    tmpl.output(links: [{href: 'http://takeyu-web.com/', title: '<タケユー・ウェブ>'},
                        {href: 'http://github.com/', title: 'Github'}]).should == '<ul><li><a href="http://takeyu-web.com/" title="&lt;タケユー・ウェブ&gt;">Link</a></li><li><a href="http://github.com/" title="Github">Link</a></li></ul>'
  end

end
