# -*- coding: utf-8 -*-
require 'spec_helper'

describe Eter::Context do

  let(:context){ Eter::Context.new(hash: {hoge: 'HashHoge', fuga: 'HashFuga'}) }

  it do
    Eter::Context.new
  end

  it do
    Eter::Context.new(a: 'A', b: 'B')[:a].should == 'A'
  end

  describe '変数操作' do
    it do
      context.params = { a: 'A', b: 'B', c: 'C' }
      context.params.should == { a: 'A', b: 'B', c: 'C' }
    end

    it do
      context.params = nil
      context.params.should == {}
    end
    
    it do
      context[:hoge].should be_nil
      context['hoge'].should be_nil
    end
    
    it do
      context.params = { a: 'A', b: 'B' }
      context[:a].should == 'A'
    context['a'].should == 'A'
    end
    
    it do
      context[:a] = 'A'
      context[:a].should == 'A'
      
      context['b'] = 'B'
      context[:b].should == 'B'
    end

    it 'hashname.hashkey でハッシュの値を取得できること' do
      context['hash.hoge'].should == 'HashHoge'
    end

    it 'hashname.hashkey でハッシュの値を設定できること' do
      context['hash.hogefuga'] = 'HashHogeFuga'
      context['hash.hogefuga'].should == 'HashHogeFuga'
      
      context['newhash.key'] = 'NewValue'
      context['newhash.key'].should == 'NewValue'      
    end
  end

  describe 'スタッシュ操作' do
    it do
      context.stash[:hoge].should be_nil
      context.stash['hoge'].should be_nil
    end

    it do
      context.stash[:hoge] = 'HOGE'
      context.stash['hoge'].should == 'HOGE'
      context.stash['fuga'] = 'FUGA'
      context.stash[:fuga].should == 'FUGA'
    end

    it do
      context.scope do
        context.stash[:hoge] = 'HOGE'
        context.stash[:hoge].should == 'HOGE'
        context.stash do
          context.stash[:hoge] = 'HOGEFUGA'
          context.stash[:hoge].should == 'HOGEFUGA'
        end
        context.stash[:hoge].should == 'HOGE'
      end
      context.stash[:hoge].should be_nil
    end
  end

end

