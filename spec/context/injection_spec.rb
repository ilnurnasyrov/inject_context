RSpec.describe Context::Injection do
  let(:context) { { repo: :fake_repo, app_logger: :fake_app_logger } }
  let(:instance) { klass.new }
  let(:klass) do
    Class.new do
      include Context::Injection.new(:repo, app_logger: :logger)
    end
  end

  describe '#context' do
    it 'returns value of @_context' do
      instance.instance_variable_set '@_context', context
      expect(instance.context).to eq context
    end
  end

  describe '#within' do
    it 'returns dup with setted context' do
      new_instance = instance.within(context)

      expect(new_instance.context).to eq context
      expect(instance.context).to be_nil
    end

    it 'checks required keys on context' do
      expect {
        instance.within(repo: :fake_repo)
      }.to raise_error Context::MissingDependency, "You didn't provide [:app_logger]"
    end
  end

  describe '#required_context_dependencies' do
    it 'returns required dependencies' do
      expect(instance.required_context_dependencies).to eq [:repo, :app_logger]
    end
  end

  it 'defines accessors to context' do
    new_instance = instance.within(context)

    expect(new_instance.repo).to eq context[:repo]
    expect(new_instance.logger).to eq context[:app_logger]
  end
end
