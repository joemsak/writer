require "writer/file_creator"

module Writer
  describe FileCreator do
    let(:file)    { double(:file) }

    subject(:creator) { described_class.new }

    before :each do
      allow(File).to receive(:open).with('filename', 'w').and_yield(file)
      allow(File).to receive(:open).with('filename', 'r')
    end

    context "with content" do
      it "writes the content" do
        allow(file).to receive(:puts)

        creator.create!('filename', 'hi')
        expect(file).to have_received(:puts).with('hi')
      end

      context 'with variables' do
        it 'fills in the variables in the template' do
          allow(creator).to receive(:template) { "hello\n%{name}, you are %{trait}" }
          allow(file).to receive(:puts)

          creator.create!('filename', 'NAME=joe TRAIT=cool')
          expect(file).to have_received(:puts).with("hello\njoe, you are cool")
        end
      end
    end

    context "without content" do
      it "leaves a blank line" do
        allow(creator).to receive(:template)
        allow(file).to receive(:puts)

        creator.create!('filename')
        expect(file).to have_received(:puts).with(nil)
      end

      it "uses a template, if it exists" do
        allow(creator).to receive(:template) { "hello\nworld" }
        allow(file).to receive(:puts)

        creator.create!('filename')
        expect(file).to have_received(:puts).with("hello\nworld")
      end
    end
  end
end
