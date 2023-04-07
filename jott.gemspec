# frozen_string_literal: true

require_relative "lib/jott/version"

Gem::Specification.new do |spec|
  spec.name = "jott"
  spec.version = Jott::VERSION
  spec.authors = ["seita1996"]
  spec.email = ["tahara.seitaro@gmail.com"]

  spec.summary = "CLI application for a little note"
  # spec.description = "TODO: Write a longer description or delete this line."
  spec.homepage = "https://rubygems.org/gems/jott"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/seita1996/jott"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = "jott"
  spec.require_paths = ["lib"]

  spec.add_dependency "colorize"
  spec.add_dependency "sqlite3"
  spec.add_dependency "thor"

  spec.add_development_dependency("rspec", "~> 3.0")
  spec.add_development_dependency("rubocop", "~> 1.21")

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
