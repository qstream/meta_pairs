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

    it "Should return added pairs loaded or not" do
      @thing.add_pair('x', 1)
      @thing.meta_pairs.loaded?.should == false
      @thing.get_value('x').should == '1'
      @thing.meta_pairs.loaded?.should == false
      # load up the association
      @thing.meta_pairs.to_a
      @thing.meta_pairs.loaded?.should == true
      @thing.get_value('x').should == '1'
      @thing.get_value('y').should be_nil
      @thing.add_pair('y', 2)
      @thing.meta_pairs.loaded?.should == false
      @thing.get_value('y').should == '2'
      @thing.add_pair('x', nil)
      @thing.meta_pairs.loaded?.should == false
      @thing.get_value('x').should == nil
    end
    it {Thing.respond_to?(:find_by_meta_key).should be_true}
    it "Should allow object destruction" do
      @thing.destroy.should be_true
    end
  end
end
