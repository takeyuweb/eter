# -*- coding: utf-8 -*-
require 'spec_helper'

describe Eter::Node::Handler::Loop do

  it "配列を処理できること" do
    tmpl = Eter::Template.new('<ul eter="loop" eter:name="array"><li eter="var" eter:name="__value__">VALUE</li></ul>')
    tmpl.output(array: ['Apple', 'Orange', 'Banana']).should == '<ul><li>Apple</li><li>Orange</li><li>Banana</li></ul>'
  end

  it "ハッシュを処理できること" do
    tmpl = Eter::Template.new('<dl eter="loop" eter:name="hash"><dt eter="var" eter:name="__key__">KEY</dt><dd eter="var" eter:name="__value__">VALUE</dd></dl>')
    tmpl.output(hash: {'Apple' => 'りんご', 'Orange' => 'みかん', 'Banana' => 'バナナ'}).should == '<dl><dt>Apple</dt><dd>りんご</dd><dt>Orange</dt><dd>みかん</dd><dt>Banana</dt><dd>バナナ</dd></dl>'
  end

  it "配列でループ変数 __counter__ がセットされること" do
    tmpl = Eter::Template.new(<<'TMPL')
  <ul eter="loop" eter:name="loop">
    <li><span eter="var" eter:name="__counter__"></span></li>
  </ul>
TMPL
    tmpl.output(loop: (1..10)).gsub(/\s{2,}/m, '').chomp.should == <<'HTML'.gsub(/\s{2,}/m, '').chomp
  <ul>
    <li><span>0</span></li>
    <li><span>1</span></li>
    <li><span>2</span></li>
    <li><span>3</span></li>
    <li><span>4</span></li>
    <li><span>5</span></li>
    <li><span>6</span></li>
    <li><span>7</span></li>
    <li><span>8</span></li>
    <li><span>9</span></li>
  </ul>
HTML
  end

  it "ハッシュでループ変数 __counter__ がセットされること" do
    tmpl = Eter::Template.new(<<'TMPL')
  <ul eter="loop" eter:name="loop">
    <li><span eter="var" eter:name="__counter__"></span></li>
  </ul>
TMPL
    tmpl.output(loop: {A: 1, B: 2, C: 3, D: 4, E: 5, F: 6, G: 7, H: 8, I: 9, J: 10}).gsub(/\s{2,}/m, '').chomp.should == <<'HTML'.gsub(/\s{2,}/m, '').chomp
  <ul>
    <li><span>0</span></li>
    <li><span>1</span></li>
    <li><span>2</span></li>
    <li><span>3</span></li>
    <li><span>4</span></li>
    <li><span>5</span></li>
    <li><span>6</span></li>
    <li><span>7</span></li>
    <li><span>8</span></li>
    <li><span>9</span></li>
  </ul>
HTML
  end

end
