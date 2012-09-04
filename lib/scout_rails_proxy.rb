module ScoutRailsProxy
end
require 'socket'
require 'set'
require 'net/http'
require File.expand_path('../scout_rails_proxy/version.rb', __FILE__)
require File.expand_path('../scout_rails_proxy/agent.rb', __FILE__)
require File.expand_path('../scout_rails_proxy/layaway.rb', __FILE__)
require File.expand_path('../scout_rails_proxy/layaway_file.rb', __FILE__)
require File.expand_path('../scout_rails_proxy/config.rb', __FILE__)
require File.expand_path('../scout_rails_proxy/environment.rb', __FILE__)
require File.expand_path('../scout_rails_proxy/metric_meta.rb', __FILE__)
require File.expand_path('../scout_rails_proxy/metric_stats.rb', __FILE__)
require File.expand_path('../scout_rails_proxy/stack_item.rb', __FILE__)
require File.expand_path('../scout_rails_proxy/store.rb', __FILE__)
require File.expand_path('../scout_rails_proxy/tracer.rb', __FILE__)
require File.expand_path('../scout_rails_proxy/transaction_sample.rb', __FILE__)
require File.expand_path('../scout_rails_proxy/instruments/process/process_cpu.rb', __FILE__)
require File.expand_path('../scout_rails_proxy/instruments/process/process_memory.rb', __FILE__)

if defined?(Rails) and Rails.respond_to?(:version) and Rails.version =~ /^3/
  module ScoutRailsProxy
    class Railtie < Rails::Railtie
      initializer "scout_rails_proxy.start" do |app|
        ScoutRailsProxy::Agent.instance.start
      end
    end
  end
else
  ScoutRailsProxy::Agent.instance.start
end

