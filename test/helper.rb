require 'test/unit'

dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift(File.join(dir, '..', 'lib'))
$LOAD_PATH.unshift(dir)

require 'tonto'

# Make sure we're in the test dir, the tests expect that to be the current
# directory.
TEST_DIR = File.join(File.dirname(__FILE__), *%w[.])

def context(*args, &block)
  return super unless (name = args.first) && block
  require 'test/unit'
  klass = Class.new(defined?(ActiveSupport::TestCase) ? ActiveSupport::TestCase : Test::Unit::TestCase) do
    def self.test(name, &block)
      define_method("test_#{name.gsub(/\W/,'_')}", &block) if block
    end
    def self.xtest(*args) end
    def self.setup(&block) define_method(:setup, &block) end
    def self.teardown(&block) define_method(:teardown, &block) end
  end
  (class << klass; self end).send(:define_method, :name) { name.gsub(/\W/,'_') }
  klass.class_eval &block
end
