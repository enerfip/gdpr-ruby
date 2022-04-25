# frozen_string_literal: true

require_relative "lib/gdpr/identity"

Gem::Specification.new do |spec|
  spec.name = Gdpr::Identity::NAME
  spec.version = Gdpr::Identity::VERSION
  spec.platform = Gem::Platform::RUBY
  spec.authors = ["Arnaud Sellenet"]
  spec.email = ["arnaud@enerfip.fr"]
  spec.homepage = "https://github.com/enerfip/gdpr-ruby"
  spec.summary = "DSL to export GDPR data for a Ruby / Rails project"
  spec.license = "MIT"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/enerfip/gdpr-ruby/issues",
    "changelog_uri" => "https://github.com/enerfip/gdpr-ruby/blob/master/CHANGES.md",
    "documentation_uri" => "https://github.com/enerfip/gdpr-ruby",
    "source_code_uri" => "https://github.com/enerfip/gdpr-ruby"
  }


  spec.required_ruby_version = "~> 3.0"
  spec.add_dependency "runcom", "~> 7.0"
  spec.add_dependency "thor", "~> 0.20"

  spec.files = Dir["lib/**/*"]
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.executables << "gdpr"
  spec.require_paths = ["lib"]
end
