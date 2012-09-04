module ScoutRailsProxy
  class Config
    def initialize(config_path = nil)
      @config_path = config_path
    end
    
    def settings
      return @settings if @settings
      load_file
    end
    
    def config_path
      @config_path || File.join(ScoutRailsProxy::Agent.instance.environment.root,"config","scout_rails_proxy.yml")
    end
    
    def config_file
      File.expand_path(config_path)
    end
    
    def load_file
      if !File.exist?(config_file)
        ScoutRailsProxy::Agent.instance.logger.warn "No config file found at [#{config_file}]."
        @settings = {}
      else
        @settings = YAML.load(ERB.new(File.read(config_file)).result(binding))[ScoutRailsProxy::Agent.instance.environment.env] || {} 
      end  
    rescue Exception => e
      ScoutRailsProxy::Agent.instance.logger.warn "Unable to load the config file."
      ScoutRailsProxy::Agent.instance.logger.warn e.message
      ScoutRailsProxy::Agent.instance.logger.warn e.backtrace
      @settings = {}
    end
  end
end