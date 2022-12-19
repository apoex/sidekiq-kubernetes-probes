module Sidekiq
  class Launcher
    private

    alias original_beat beat

    def beat
      FileUtils.touch(File.join(Dir.getwd, "tmp", "sidekiq_health"))
      original_beat
    end
  end
end
