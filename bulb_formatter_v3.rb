$LOAD_PATH.concat Dir.glob("#{ENV['rvm_path']}/gems/#{ENV['RUBY_VERSION']}@global/gems/*/lib")
require 'serialport'

class BulbFormatterV3
  RSpec::Core::Formatters.register self, :start, :example_failed, :dump_summary

  def initialize(output)
    @output = SerialPort.new("/dev/tty.usbmodem12341", 9600)
  end

  def start(notification)
    @output.write 'y'
  end

  def example_failed(notification)
    @output.write 'f'
  end

  def dump_summary(notification)
    if notification.failure_count == 0
      @output.write 'g'
    else
      @output.write 'r'
    end
  end
end
