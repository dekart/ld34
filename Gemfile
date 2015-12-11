def windows_only(require_as)
  RbConfig::CONFIG['host_os'] =~ /mingw|mswin/i ? require_as : false
end

def linux_only(require_as)
  RbConfig::CONFIG['host_os'] =~ /linux/ ? require_as : false
end

# Mac OS X
def darwin_only(require_as)
  RbConfig::CONFIG['host_os'] =~ /darwin/ ? require_as : false
end


source 'https://rubygems.org'


gem 'activesupport'
gem 'rake'
gem 'guard'
gem 'guard-coffeescript'

# Notification libraries for Guard
gem 'terminal-notifier-guard', :require => darwin_only('terminal-notifier-guard')
gem 'libnotify', :require => linux_only('libnotify')
