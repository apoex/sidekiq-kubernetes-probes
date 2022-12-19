require "sidekiq/kubernetes/probes/version"

require "sidekiq/launcher"

class SidekiqNotLoadedError < StandardError; end

if Sidekiq::Launcher.private_instance_methods.include?(:heartbeat)
  require "sidekiq/kubernetes/probes/patch_heartbeat"
elsif Sidekiq::Launcher.private_instance_methods.include?(:beat)
  require "sidekiq/kubernetes/probes/patch_beat"
else
  raise SidekiqNotLoadedError, "[sidekiq-kubernetes-probes] I'm not compatible with this version of sidekiq. " \
    "Because Sidekiq::Launcher does not implement the heartbeat or beat private method"
end
