require "sidekiq/kubernetes/probes/version"

require "sidekiq/launcher"

class SidekiqNotLoadedError < StandardError; end

unless Sidekiq::Launcher.private_instance_methods.include?(:heartbeat)
  raise SidekiqNotLoadedError, "[sidekiq-kubernetes-probes] I'm not compatible with this version of sidekiq. " \
    "Because Sidekiq::Launcher does not respond to the heartbeat method"
end

module Sidekiq
  class Launcher
    private

    alias original_heartbeat heartbeat

    def heartbeat
      FileUtils.touch(File.join(root, "tmp", "sidekiq_health"))
      original_heartbeat
    end

    def root
      Dir.getwd
    end
  end
end
