module Sidekiq
  class Launcher
    private

    alias original_heartbeat heartbeat

    def heartbeat
      FileUtils.touch(File.join(Dir.getwd, "tmp", "sidekiq_health"))
      original_heartbeat
    end
  end
end
