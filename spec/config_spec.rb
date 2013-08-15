require "writer"
module Creators; class MyCreator; end; end
module Namers; class MyNamer; end; end;

module Writer
  describe Configuration do
    after :all do
      Writer.set_default_config!
    end

    it "defaults template_path blank" do
      Writer.template_path.should be_blank
    end

    it "defaults date_format to american" do
      # and in a format that helps with file sorting
      Writer.date_format.should == '%Y-%m%b-%d'
    end

    it "takes a template_path" do
      Writer.configure do |c|
        c.template_path = 'hi'
      end

      Writer.template_path.should == 'hi'
    end

    it "takes a date_format" do
      Writer.configure do |c|
        c.date_format = 'hello there'
      end

      Writer.date_format.should == 'hello there'
    end

    it "defaults creator to FileCreator" do
      Writer.creator.should == FileCreator
    end

    it "takes a creator" do
      Writer.configure do |c|
        c.creator = 'Creators::MyCreator'
      end

      Writer.creator.should == Creators::MyCreator
    end

    it "defaults namer to FileNamer" do
      Writer.namer.should == FileNamer
    end

    it "takes a namer" do
      Writer.configure do |c|
        c.namer = 'Namers::MyNamer'
      end

      Writer.namer.should == Namers::MyNamer
    end
  end
end
