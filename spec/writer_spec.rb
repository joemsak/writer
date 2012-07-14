require 'writer'

describe Writer do
  let(:file) do
    File.open('2012-01Jan-03.md')
  end

  before :each do
    Date.stub(:today) do
      Date.new(2012, 1, 3)
    end
  end

  after :all do
    File.delete('2012-01Jan-03.md')
    File.delete('.template')
    File.delete('My custom filename.txt')
  end

  it "creates today's file" do
    Writer.write!
    file.should_not be_nil
  end

  it "creates the file with your custom name" do
    filename = "My custom filename.txt"
    Writer.write!(filename)
    File.open(filename)
  end

  it "uses a template, if it exists" do
    body = "hello\nworld"

    File.open('.template', 'w') do |f|
      f.puts body
    end

    Writer.configure do |c|
      c.template_path = '.template'
    end

    Writer.write!
    file.read.should == body + "\n"
  end
end
