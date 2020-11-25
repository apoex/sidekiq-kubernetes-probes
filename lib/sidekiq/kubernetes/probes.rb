require "sidekiq/kubernetes/probes/version"

class SidekiqNotLoadedError < StandardError; end

unless defined?(Sidekiq)
  raise SidekiqNotLoadedError, "[sidekiq-kubernetes-probes] sidekiq is not loaded. " \
    "Make sure that the sidekiq gem is loaded before `sidekiq-kubernetes-probes` in your Gemfile"
end

unless Sidekiq::Launcher.respond_to?(:heartbeat)
  raise SidekiqNotLoadedError, "[sidekiq-kubernetes-probes] I'm not compatible with this version of sidekiq. " \
    "Because Sidekiq::Launcher does not respond to the heartbeat method"
end

module Sidekiq
  class Launcher
    alias original_heartbeat heartbeat

    def heartbeat
      FileUtils.touch(File.join(root, "tmp", "sidekiq_health"))
      original_heartbeat
    end

    private

    def root
      Dir.getwd
    end
  end
end
