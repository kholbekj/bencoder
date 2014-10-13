class BEncoder
  def self.encode(object)
    case object
    when Symbol
      encode object.to_s
    when String
      "#{object.length}:#{object}"
    when Integer
      "i#{object}e"
    when Array
      encoded_content = object.inject("l") { |result, el| result += encode(el) }
      encoded_content += "e"
    when Hash
      encoded = object.inject("d") { |result, (k,v)| result += "#{encode(k.to_s)}#{encode(v)}" }
      encoded += "e"
    end
  end
end