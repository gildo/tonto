dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift(File.join('tonto'))
$LOAD_PATH.unshift(dir)

require 'tonto/repo'

module Tonto

  VERSION = "0.1.0"

end
