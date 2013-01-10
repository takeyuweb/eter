class Eter::Context

  def initialize(params={})
    @params = params || {}
  end

  def params
    @params
  end

  def params=(params)
    @params = params || {}
  end

  def [](key)
    keys = key.to_s.split('.')
    key = keys.pop
    (keys.empty? ? params : keys.inject(params){|p, k| p[k.to_sym] || {} })[key.to_sym]
  end

  def []=(key, value)
    keys = key.to_s.split('.')
    key = keys.pop
    p = keys.empty? ? params : keys.inject(params){|p, k| p[k.to_sym] ||= {} }
    p[key.to_sym] = value
  end

  def stash
    @stash ||= Eter::Context::Stash.new
  end

  def stash=(stash)
    @stash = stash
  end

  def scope(&block)
    _stash = stash
    self.stash = stash.dup
    block.call
  ensure
    self.stash = _stash
  end

end

require 'eter/context/stash'
