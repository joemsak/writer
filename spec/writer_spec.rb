require 'writer'

describe Writer do
  before :each do
    Date.stub(:today) do
      Date.new(2012, 1, 3)
    end
  end

  after :all do
    cleanup_files
  end

  it "creates today's file, blank" do
    file = Writer.write!
    file.read.should == "\n"
  end

  it "prevents overwriting" do
    Writer.write!
    Writer.write!

    File.open('2012-01Jan-03--2.md')
    File.open('2012-01Jan-03--3.md')
  end

  it "creates the file with your custom name" do
    filename = "My custom filename.txt"
    Writer.write!(filename)
    File.open(filename)
  end

  it "uses a template, if it exists" do
    body = "hello\nworld"
    Writer.write!('.template', body)

    Writer.configure do |c|
      c.template_path = '.template'
    end

    file = Writer.write!
    file.read.should == body + "\n"
  end
end

def cleanup_files
  File.delete('2012-01Jan-03.md')
  File.delete('2012-01Jan-03--2.md')
  File.delete('2012-01Jan-03--3.md')
  File.delete('2012-01Jan-03--4.md')
  File.delete('.template')
  File.delete('My custom filename.txt')
end
