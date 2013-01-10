class Eter::Context::Stash < Hash
  
  alias :original_writer :[]=
  alias :original_reader :[]
    
  def []=(key, value)
    original_writer(convert_key(key), value)
  end

  def [](key)
    original_reader(convert_key(key))
  end

  private
  def convert_key(key)
    key.kind_of?(Symbol) ? key.to_s : key
  end

end
