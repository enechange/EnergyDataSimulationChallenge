require_relative 'lib/murasaki/version'

Gem::Specification.new do |spec|
  spec.name          = 'murasaki'
  spec.version       = Murasaki::VERSION
  spec.authors       = ['dopin']
  spec.email         = ['dopinninja@gmail.com']

  spec.summary       = '電気量機計算シミューレーター的なもの'
  spec.description   = 'This is not production-ready and it will never be.'
  spec.homepage      = 'https://github.com/dopin/EnergyDataSimulationChallenge'
  spec.license       = ''
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.2')

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
