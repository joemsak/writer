require "writer"
class MyCreator; end
class MyNamer; end

module Writer
  describe Configuration do
    after :all do
      Writer.config = Configuration.new
    end

    it "defaults template_path to nil" do
      Writer.template_path.should be_nil
    end

    it "takes a template_path" do
      Writer.configure do |c|
        c.template_path = 'hi'
      end

      Writer.template_path.should == 'hi'
    end

    it "defaults creator to FileCreator" do
      Writer.creator.should == FileCreator
    end

    it "takes a creator" do
      Writer.configure do |c|
        c.creator = :my_creator
      end

      Writer.creator.should == MyCreator
    end

    it "defaults namer to FileNamer" do
      Writer.namer.should == FileNamer
    end

    it "takes a namer" do
      Writer.configure do |c|
        c.namer = :my_namer
      end

      Writer.namer.should == MyNamer
    end
  end
end
