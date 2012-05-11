require 'meta_pairs/version'
require 'meta_pairs/meta_pair'

module MetaPairs
  autoload :MetaPairObject,   'meta_pairs/meta_pair_object'
  require 'meta_pairs/railtie' if defined?(Rails) && Rails::VERSION::MAJOR >= 3
end

ActiveRecord::Base.send :include, MetaPairs::MetaPairObject