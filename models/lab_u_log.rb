class LabULog
  def self.info(message = nil)
    @info_log ||= Logger.new(Rails.root.join("log", "labu_info.log"))
    @info_log.info(message)
  end

  def self.warn(message = nil)
    @warn_log ||= Logger.new(Rails.root.join("log", "labu_warn.log"))
    @warn_log.warn(message)
  end

  def self.error(message = nil)
    @error_log ||= Logger.new(Rails.root.join("log", "labu_error.log"))
    @error_log.error(message)
  end

  def self.fatal(message = nil)
    @fatal_log ||= Logger.new(Rails.root.join("log", "labu_fatal.log"))
    @fatal_log.fatal(message)
  end

  def self.debug(message = nil)
    @debug_log ||= Logger.new(Rails.root.join("log", "labu_debug.log"))
    @debug_log.debug(message)
  end
end
