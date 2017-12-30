RSpec.describe InjectContext::InstanceBuilder do
  let(:klass) do
    Class.new do
      attr_reader :_context, :args

      def initialize(args)
        @args = args
      end
    end
  end

  let(:context) { double(:context) }

  it 'builds instance with context' do
    builder = InjectContext::InstanceBuilder.new(klass, context)

    instance = builder.new(:args)

    expect(instance).to be_instance_of klass
    expect(instance._context).to eq context
    expect(instance.args).to eq :args
  end
end
