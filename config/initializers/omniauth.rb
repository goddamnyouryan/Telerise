require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'qmtD5hsheCt0geCmT5deHQ', 'VbgogqQxEgnZGhq80PeVFgPXPno127ogegiiym6vE8'
  provider :facebook, '205707882783305', '94d28c857ef4de951f47d8e9df81bb11'
  provider :open_id, OpenID::Store::Filesystem.new('/tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  provider :foursquare, 'ZZUBTNRMFIGUO2LWZFUMGPMWM514FULAAV4Y4BB15QJM4LCA', '2SHMFHA5CFVLE5LCT2ZO0CBBREPEG01LPY4EXR43PFF1Y5H0'
  #provider :linkedin, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  #provider :instagram, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  provider :netflix, 'maf8sy6duu3sf7dhyveubadr', 'sZbcycdky8'
  #provider :tumblr, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  provider :you_tube, 'telerise.heroku.com', 'A4X5xeQ2FWxpuunsWH1RKYTS'
  provider :vimeo, '2647fbb18234ed959cecd96525be1bfb', '29df10b13fd88267'
end