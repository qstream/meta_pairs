class MetaPair < ActiveRecord::Base
  attr_accessible :value, :public
  belongs_to :object, :polymorphic => true
  belongs_to :owner, :polymorphic => true

  scope :owned_by, lambda {|owner| {:conditions => {:owner_id => owner.id, :owner_type => owner.class.name}}}
  scope :type, lambda {|type| {:conditions => {:object_type => type}}}
  scope :keys, :group => 'meta_pairs.key asc'
end
