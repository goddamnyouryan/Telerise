require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'qmtD5hsheCt0geCmT5deHQ', 'VbgogqQxEgnZGhq80PeVFgPXPno127ogegiiym6vE8'
  provider :facebook, '205707882783305', '94d28c857ef4de951f47d8e9df81bb11', {:client_options => {:ssl => {:ca_file => "/usr/lib/ssl/certs/ca-certificates.crt"}}}
  provider :open_id, OpenID::Store::Filesystem.new('/tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  provider :foursquare, 'ZZUBTNRMFIGUO2LWZFUMGPMWM514FULAAV4Y4BB15QJM4LCA', '2SHMFHA5CFVLE5LCT2ZO0CBBREPEG01LPY4EXR43PFF1Y5H0', {:client_options => {:ssl => {:ca_file => "/usr/lib/ssl/certs/ca-certificates.crt"}}}
  provider :linked_in, 'Au88lrNhLO33Qu6SOgulv1HzHS7ims4T2ZO1bxTt1VAwOGX6ovuHknf4SyLXu0vd', 'aZ6Y-e95c3hu-Ine46KTsKw7m6lVv7_X-0cMi2dnnrmzlUUdY4RYt0NYmxQJno2Q'
  provider :yahoo, 'dj0yJmk9TUxLRVQ5S0NjMDNlJmQ9WVdrOVNHRjZlalZ2Tm1zbWNHbzlNekk1TXpVME5UWXkmcz1jb25zdW1lcnNlY3JldCZ4PTZh', '3e089e98a823d39b8084286b30e75713a6445702'
  provider :netflix, 'maf8sy6duu3sf7dhyveubadr', 'sZbcycdky8'
  #provider :tumblr, 'FRbjNnglNrjWZOonMSZwuf1y0LIoLXqHGNVmGkQrocgxVtDROz', 'SEsBe4P4SBeGWIReiuBLTnQ8CwykIqr8ywhvug6SFdKnFt1Y0A'
  provider :you_tube, 'www.telerise.tv', '_FfsncDmBjxjpOY1qtMiaUdg'
  provider :vimeo, '2647fbb18234ed959cecd96525be1bfb', '29df10b13fd88267'
end