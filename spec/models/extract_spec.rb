require 'spec_helper'

describe Extract do

  it 'should extract entities ok' do
    text = "They are expected to involve a 50 write-down of Greece's massive government debt, the BBC's business editor Robert Peston says"
    parsed = Extract.extract text
    parsed.should == [{:text => "Greece", :type => "LOCATION" }, {:text => "BBC", :type => "ORGANIZATION" }, {:text => "Robert Peston", :type => "PERSON" }]
  end

  context ".parse" do
    it "should parse ORGANIZATION correctly" do
      parsed = Extract.parse("the/O European/ORGANIZATION Central/ORGANIZATION Bank/ORGANIZATION -LRB-/O ECB/ORGANIZATION -RRB-/O to/O lend/O")
      parsed.should == [{:text => "European Central Bank", :type => "ORGANIZATION" }, {:text=> "ECB", :type => "ORGANIZATION"}]
    end
    it "should parse LOCATION correctly" do
      parsed = Extract.parse("eduction/O in/O Greece/LOCATION 's/O repay")
      parsed.should == [{:text => "Greece", :type => "LOCATION" }]
    end
    it "should parse PERSON correctly" do
      parsed = Extract.parse(" editor/O Robert/PERSON Peston/PERSON says/O    ")
      parsed.should == [{:text => "Robert Peston", :type => "PERSON" }]
    end
  end

end