# encoding: utf-8
Gem::Specification.new do |s|
  s.name = "bolt"
  s.version = "0.2.0" #  http://semver.org/  +  http://guides.rubygems.org/specification-reference
  s.author = "elpulgardelpanda"
  s.email = "tech@elpulgardelpanda.com"
  s.platform = Gem::Platform::RUBY
  s.summary = "A world-record-fast task runner based on Ruby processes"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- test/*`.split("\n")
  s.require_paths = ['lib']
  s.executables << 'bolt_setup'

  s.add_runtime_dependency 'mongo', '~> 1.10.2'
  s.add_runtime_dependency 'bson_ext', '~> 1.10.2'
  s.add_runtime_dependency 'mail','~> 2.5.3'
  # stones... but stones is on Gemfile while we need it from git

  s.required_ruby_version = '>= 2.1.0'
  s.has_rdoc = false

  s.post_install_message = "

      Now you should run `bolt_setup` from your app's folder, and add the
      resulting `bolt_watchdog` to your crontab.

  "
end
