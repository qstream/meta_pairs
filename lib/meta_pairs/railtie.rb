require 'meta_pairs'
require 'rails'

module MetaPairs
  class Railtie < Rails::Railtie

    initializer "meta_pairs.active_record" do |app|
      ActiveSupport.on_load :active_record do
        include MetaPairs::MetaPairObject
      end
    end
  end
end