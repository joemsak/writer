require 'writer'

describe Writer do
  it "creates today's file, blank" do
    file = Writer.write!('hi')
    file.read.should == "\n"
    File.delete('hi')
  end

  it "plays well with nils" do
    file = Writer.write!(nil, nil)
    file.read.should == "\n"
    delete_files
  end

  it "creates the file with your custom name" do
    filename = "My custom filename.txt"

    Writer.write!(filename)
    File.delete(filename)
  end

  it "uses a template, if it exists" do
    body = "hello\nworld"
    Writer.write!('.template', body)

    Writer.configure do |c|
      c.template_path = '.template'
    end

    file = Writer.write!
    file.read.should == body + "\n"
    File.delete('.template')
    delete_files
  end
end

def delete_files
  Dir.glob("20*.md") do |filename|
    File.delete(filename)
  end
end
