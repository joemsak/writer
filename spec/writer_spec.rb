require 'writer'

describe Writer do
  after :all do
    delete_files
  end

  it "creates today's file, blank" do
    file = Writer.write!
    file.read.should == "\n"
  end

  it "plays well with nils" do
    file = Writer.write!(nil, nil)
    file.read.should == "\n"
  end

  it "uses your custom name" do
    filename = "My custom filename.txt"

    Writer.write!(filename)
    File.delete(filename)
  end
end

def delete_files
  Dir.glob("20*.md") do |filename|
    File.delete(filename)
  end
end
