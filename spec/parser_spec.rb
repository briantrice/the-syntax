require 'thesyntax'
#require 'parser'

def parsing(string, rule=nil)
  parser = TheSyntax::Parser.new(string)
  unless parser.parse(rule)
    raise parser.failure_info
  end
  parser.result
end

describe TheSyntax::Parser do

  describe "#nothing" do
    it "parses nothing as nothing" do
      parsing('').should == []
    end
  end

  describe "#number" do

    it "parses positives integers" do
      parsing('7', 'number').should == 7
      parsing('+1', 'number').should == 1
      parsing('12324343', 'number').should == 12324343
    end

    it "parses zero" do
      parsing('0', 'number').should == 0
      parsing('-0', 'number').should == 0
      parsing('+0', 'number').should == 0
    end

    it "parses negative integers" do
      parsing('-1', 'number').should == -1
    end

    it "parses floats" do
      parsing('1.0', 'number').should == 1.0
      parsing('-1.0', 'number').should == -1.0
      parsing('3.14159', 'number').should == 3.14159
    end

    it "parses floats with exponent" do
      parsing('1.0e3', 'number').should == 1000
      parsing('2.0e-2', 'number').should == 0.02
      parsing('1e0', 'number').should == 1
    end

  end

  describe "#string" do

    it "parses empty strings" do
      parsing('""', 'string').should == ''
    end

    it "parses simple strings" do
      parsing('"abc"', 'string').should == 'abc'
    end

    it "parses strings with escapes" do
      parsing('"ab\\nc"', 'string').should == "ab\nc"
      parsing('"ab\\sc"', 'string').should == 'ab c'
      parsing('"ab\\\\c"', 'string').should == 'ab\c'
    end

    it "parses numeric string escapes" do
      parsing('"\65"', 'string').should == 'A'
      parsing('"\065"', 'string').should == 'A'
      parsing('"\x65"', 'string').should == 'e'
    end

  end

  describe "#unary_selector" do

    it "parses unary selectors" do
      parsing('foo', 'unary_selector').should == 'foo'
      parsing('foo_bar', 'unary_selector').should == 'foo_bar'
      parsing('foo-bar', 'unary_selector').should == 'foo-bar'
      parsing('foo+bar', 'unary_selector').should == 'foo+bar'
    end

  end

  describe "#symbol" do

    it "parses simple symbols" do
      parsing('#foo', 'symbol').should == :foo
      #FIXME offends Emacs ruby-mode:
      #parsing('#+', 'symbol').should == :"+"
    end

    it "parses quoted symbols" do
      parsing('#"foo"', 'symbol').should == :foo
    end

  end

  describe "#keyword" do

    it "parses simple keywords" do
      parsing('foo:', 'keyword').should == :"foo:"
      parsing('foo_bar:', 'keyword').should == :"foo_bar:"
    end

  end

  describe "#list" do

    it "parses empty lists" do
      parsing('[]').should == []
    end

    it "parses simple lists" do
      parsing('[1]').should == [1]
      #parsing('[Nil]').should == [Nil]
      parsing('[3, 4]').should == [3, 4]
    end

    it "parses nested lists" do
      parsing('[[]]').should == [[]]
      parsing('[[1]]').should == [[1]]
      parsing('[[1], 2]').should == [[1], 2]
    end

  end

#   describe "#binary_send" do
#     parser = TheSyntax::Parser.new('3 + 4')
#     parser.result.should == 7
#   end

end
