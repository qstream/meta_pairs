
module MetaPairs
  module MetaPairObject #:nodoc:

    def self.included(mod)
      mod.extend(ClassMethods)
    end

    module ClassMethods
      def owns_meta_pairs
        has_many :meta_pairs, :as => :owner, :dependent => :destroy, :class_name => "MetaPair"
        class << self
          def find_by_meta_key(key)
            joins(:meta_pairs).where(:meta_pairs => {:key => key})
          end
          def find_by_meta_pair(key, value)
            joins(:meta_pairs).where(:meta_pairs => {:key => key, :value => value})
          end
        end
        include MetaPairs::MetaPairObject::OwnsInstanceMethods
      end
      def has_meta_pairs
        has_many :meta_pairs, :as => :object, :dependent => :destroy
        class << self
          def find_by_meta_key(key)
            joins(:meta_pairs).where(:meta_pairs => {:key => key})
          end
          def find_by_meta_pair(key, value)
            joins(:meta_pairs).where(:meta_pairs => {:key => key, :value => value})
          end
        end
        include MetaPairs::MetaPairObject::HasInstanceMethods
      end
    end
    module OwnsInstanceMethods
      def get_keys
        meta_pairs.keys.map {|mp| mp.key}
      end
    end

    module HasInstanceMethods
      def get_value(key, owner=nil)
        if owner.present?
          if meta_pairs.loaded?
            mp = meta_pairs.detect{ |mp| mp.owner_id == owner.id && mp.owner_type = owner.class.base_class.name && mp.key == key }
          else
            mp = meta_pairs.owned_by(owner).find_by_key(key)
          end
        else
          if meta_pairs.loaded?
            mp = meta_pairs.detect{ |mp| mp.key == key }
          else
            mp = meta_pairs.find_by_key(key)
          end
        end
        if mp
          mp.value
        else
          nil
        end
      end

      def add_pair(key, value, owner=nil, is_public=false)
        if !value || value.blank?
          if owner.present?
            mp = meta_pairs.owned_by(owner).find_by_key(key)
          else
            mp = meta_pairs.find_by_key(key)
          end
          mp.destroy if mp
          if mp && meta_pairs.loaded?
            self.association(:meta_pairs).reset
          end
        else
          if owner.present?
            mp = meta_pairs.owned_by(owner).find_or_initialize_by_key(key)
          else
            mp = meta_pairs.find_or_initialize_by_key(key)
          end
          mp.update_attributes(:value => value, :public => is_public)
          if meta_pairs.loaded?
            self.association(:meta_pairs).reset
          end
        end
      end

    end
  end
end
