if RbConfig::CONFIG['target_os'] =~ /mac|darwin/i
  notification :terminal_notifier, activate: 'com.googlecode.iTerm2'
else
  notification :gntp, host: 'localhost'
end
