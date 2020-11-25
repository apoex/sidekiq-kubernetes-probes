require_relative 'lib/sidekiq/kubernetes/probes/version'

Gem::Specification.new do |spec|
  spec.name          = "sidekiq-kubernetes-probes"
  spec.version       = Sidekiq::Kubernetes::Probes::VERSION
  spec.authors       = ["Micke Lisinge"]
  spec.email         = ["hi@micke.me"]

  spec.summary       = %q{Kubernetes probes for sidekiq}
  spec.description   = %q{Kubernetes probes for sidekiq}
  spec.homepage      = "https://github.com/apoex/sidekiq-kubernetes-probes"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]
end
