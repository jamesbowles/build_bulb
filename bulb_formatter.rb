require 'rspec/core/formatters/progress_formatter'
# dirty hack, see: https://github.com/carlhuda/bundler/issues/183
$LOAD_PATH.concat Dir.glob("#{ENV['rvm_path']}/gems/#{ENV['RUBY_VERSION']}@global/gems/*/lib")
require 'serialport'

class BulbFormatter < RSpec::Core::Formatters::ProgressFormatter

  def initialize(output)
    super(output)
    begin
      @bulb = SerialPort.new("/dev/tty.usbmodem12341", 9600)
      @bulb.write 'y'
    rescue
    end
  end

  def dump_summary(duration, example_count, failure_count, pending_count)
    super

    if failure_count.zero?
      @bulb.try(:write, "g")
    else
      @bulb.try(:write, "r")
    end

    @bulb.try(:close)
  end
end
