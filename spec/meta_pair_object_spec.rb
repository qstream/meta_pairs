require 'spec_helper'

describe MetaPairs do

  it {should be_a(Module)}

  describe Widget do
    
    before :each do
      @widget = Widget.create :name => "My Widget"
    end
    subject {@widget}
    it {should be_valid}
    it {@widget.respond_to?(:get_keys).should be_true}
    it {Widget.respond_to?(:find_by_meta_key).should be_true}
  end
  describe Thing do
    
    before :each do
      @thing = Thing.create :name => "My Thing"
    end
    subject {@thing}
    it {should be_valid}
    it {@thing.respond_to?(:get_value).should be_true}
    it {Thing.respond_to?(:find_by_meta_key).should be_true}
    it "Should allow object destruction" do
      @thing.destroy.should be_true
    end
  end
end