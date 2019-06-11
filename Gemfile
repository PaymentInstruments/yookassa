source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in yandex-checkout.gemspec
gemspec

gem 'evil-client', git: 'https://github.com/paderinandrey/evil-client.git'

group :development, :test do
  gem 'pry',        platform: :mri
  gem 'pry-byebug', platform: :mri
end
