require 'rspec/core/formatters/progress_formatter'
# dirty hack, see: https://github.com/carlhuda/bundler/issues/183
$LOAD_PATH.concat Dir.glob("#{ENV['rvm_path']}/gems/#{ENV['RUBY_VERSION']}@global/gems/*/lib")
require 'serialport'

class BulbFormatter < RSpec::Core::Formatters::ProgressFormatter

  DEVICE = "/dev/tty.usbmodem12341"

  def initialize(output)
    super(output)
    begin
      @bulb = SerialPort.new(DEVICE, 9600)
      
      if @buld.nil?
        puts "\nWARNING: Couldn't find build bulb"
        return
      end
      
      @bulb.write 'y'
    rescue
    end
  end

  def dump_summary(duration, example_count, failure_count, pending_count)
    super

    if @buld.nil?
      puts "\nWARNING: Couldn't find build bulb"
      return
    end

    if failure_count.zero?
      @bulb.try(:write, "g")
    else
      @bulb.try(:write, "r")
    end

    @bulb.try(:close)
  end
end
