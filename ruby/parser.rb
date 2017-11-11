#
# Parse an invented format.  Parse a provided string and return objects
# representing the parsed content. The format is described below using EBNF and
# a bit of regex. Each line describes a token in the grammar followed by
# examples.  In person, they just gave a few examples of each.
#
#   * integer ::=  `"i", \d+, "e";`  i10e, i4e
#   * string  ::= `\d+, ":", .{\1}`, 2:ab, 4:abcd
#   * array   ::= `"a", (integer | string | array )+, "e"`, a2:abi34ee
#   * dict    ::= `"h", (string, (integer | string | array | dict))+, "e"`, h2:abi34ee

require 'strscan'

# Parser parses an invented format.
#
class Parser
  DEBUG = false

  def self.parse(input)
    new(input).parse
  end

  def initialize(input)
    @input = input
    @scanner = StringScanner.new(@input)
  end

  def reset(input)
    @input = input
    @scanner = StringScanner.new(@input)
    self
  end

  def unparsed
    @scanner.rest
  end

  def debug(msg, obj = nil)
    msg = "== Debug: #{msg}" unless msg.class != String
    warn msg if DEBUG
    warn obj if DEBUG && !obj.nil?
  end

  def parse_int
    ret = nil
    intstring = @scanner.scan(/^i\d+e/)
    return nil if intstring.nil?
    integer = Regexp.last_match[1].to_i if /^i(\d+)e/ =~ intstring
    ret = integer if integer
    ret
  end

  def parse_string
    ret = nil
    return nil if @input !~ /^\d+:/
    matchdata = /^(\d+):/.match(@input)
    integer = matchdata[1].to_i
    return nil if integer <= 0

    regex = '^\d+:(.{' + integer.to_s + '})'
    parse_string = @scanner.scan(/#{regex}/)
    return nil if parse_string.nil? || parse_string.empty?

    matchdata = /#{regex}/.match(parse_string)
    string = matchdata[1] if matchdata && !matchdata.to_a.empty? # length > 0

    ret = string if string
    ret
  end

  def parse_array
    return [] if @input !~ /^a/
    @scanner.scan(/a/)

    # Parse the rest with a new parser which should fail when it encounters the
    # unmatched 'e' for the end of this array.
    parse_string = @scanner.rest
    parser = Parser.new(parse_string)
    ret = parser.parse
    @scanner.string = parser.unparsed

    @scanner.scan(/e/)
    ret
  end

  def parse_dict
    ret = {}
    return ret if @input !~ /^d/
    @scanner.scan(/d/)

    # Parse the rest with a new parser which should fail when it encounters the
    # unmatched 'e' for the end of this dict.
    parse_string = @scanner.rest
    parser = Parser.new(parse_string)
    ary = parser.parse
    debug 'parsed dict array', ary
    ret = Hash[ary.each_slice(2).to_a]
    debug 'parsed dict ret', ret
    @scanner.string = parser.unparsed

    @scanner.scan(/e/)
    ret
  end

  def parse
    parsed = []
    return parsed if @input.nil? || @input.length.zero?
    debug "Parse: \"#{@input}\""
    loop do
      break if @input.length.zero?
      case @input
      when /^i\d+e/                  # integer
        integer = parse_int
        debug "integer: #{integer}"
        parsed << integer
      when /^(\d+):.{1,}/            # string
        string = parse_string
        debug "string: #{string}"
        parsed << string
      when /^a/                      # array
        ary = parse_array
        debug "array: #{ary}, parsed: #{parsed}"
        parsed << ary
        debug "array: #{ary}, parsed: #{parsed}"
      when /^d/                      # dictionary
        dict = parse_dict
        debug "dict: #{dict}, parsed: #{parsed}"
        parsed << dict
        debug "dict: #{dict}, parsed: #{parsed}"
      else
        debug "unrecognized token at: #{@input}"
        break
      end
      @input = @scanner.rest
    end
    parsed
  end

  # A class/static version.
  def self.parse_int(input)
    Parser.new(input).parse_int
  end

  # A class/static version.
  def self.parse_string(input)
    Parser.new(input).parse_string
  end
end
