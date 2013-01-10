require 'cgi'

class Eter::Node::Handler::Var < Eter::Node::Handler
  
  def process(context, &block)
    name = params['name'].to_s.to_sym
    value = context[name]
    if operand = params['value']
      context[name] =  case params['op']
                       when '+'
                         if (float_string?(value) || float_string?(operand)) && (!integer_string?(value) || !integer_string?(operand) )
                           value.to_f + operand.to_f
                         else
                           value.to_i + operand.to_i
                         end
                       else
                         operand
                       end
      value = nil
      @deletion = true
    end

    if value
      escape = params['escape']      
      case escape
      when 'html'
        value = CGI.escapeHTML(value)
      end
    end

    value
  end

  def integer_string?(str)
    Integer(str.to_s)
    true
  rescue ArgumentError
    false
  end
  
  def float_string?(str)
    Float(str.to_s)
    true
  rescue ArgumentError
    false
  end

end
