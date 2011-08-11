require 'thesyntax'
#require 'parser'

def parse_of(string)
  parser = TheSyntax::Parser.new(string)
  parser.result
end

describe TheSyntax::Parser do

  describe "#nothing" do
    parse_of('').should == nil
  end
#   describe "#numbers" do
#     parse_of('7').should == 7
#   end
#   describe "#sums" do
#     parser = TheSyntax::Parser.new('3 + 4')
#     parser.result.should == 7
#   end
end
