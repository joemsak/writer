require "writer"

module Writer
  describe FileNamer do
    before :each do
      File.stub(:exists?)
          .with(/^\D+[^(\-\-)\d]$/)
          .and_return(true)

      File.stub(:exists?)
          .with(/^\S*\d+.*$/)
          .and_return(false)
    end

    it "defaults to today's date" do
      Date.stub(:today) do
        Date.new(2012, 1, 3)
      end
      name = FileNamer.name_for(nil)
      name.should == "2012-01Jan-03.md"
    end

    it "uses a configured date format" do
      Writer.configure do |config|
        config.date_format = '%e-%m%b-%Y'
      end

      Date.stub(:today) do
        Date.new(2013, 8, 12)
      end

      name = FileNamer.name_for(nil)
      name.should == "12-08Aug-2013.md"
    end

    it "prevents overwriting" do
      name = FileNamer.name_for('hi')
      name.should == 'hi--02'
    end

    it "plays well with standard filenames" do
      name = FileNamer.name_for('std.rb')
      name.should == 'std.02.rb'
    end

    it "plays well with a dot at the end" do
      name = FileNamer.name_for('dot.')
      name.should == 'dot.02.'
    end

    it "plays well with a dot at the beginning" do
      name = FileNamer.name_for('.dot')
      name.should == '.dot.02'
    end

    it "plays well with multiple dots" do
      name = FileNamer.name_for('some.jquery.file')
      name.should == 'some.jquery.02.file'
    end
  end
end
