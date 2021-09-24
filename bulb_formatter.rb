require 'rspec/core/formatters/progress_formatter'
# dirty hack, see: https://github.com/carlhuda/bundler/issues/183
$LOAD_PATH.concat Dir.glob("#{ENV['rvm_path']}/gems/#{ENV['RUBY_VERSION']}@global/gems/*/lib")
require 'rubyserial'

class BulbFormatter < RSpec::Core::Formatters::ProgressFormatter

  DEVICE = "/dev/tty.usbmodem12341"

  def initialize(output)
    super(output)
    begin
      @bulb = Serial.new(DEVICE, 9600)
      
      if @bulb.nil?
        puts "\nWARNING: Couldn't find build bulb"
        return
      end
      
      @bulb.write 'y'
    rescue
    end
  end

  def dump_summary(duration, example_count, failure_count, pending_count)
    super

    if @bulb.nil?
      puts "\nWARNING: Couldn't find build bulb"
      return
    end

    if failure_count.zero?
      @bulb.write "g"
    else
      @bulb.write "r"
    end

    @bulb.close
  end
end
