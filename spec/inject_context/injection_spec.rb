RSpec.describe InjectContext::Injection do
  let(:klass) { Class.new }
  let(:context) { { repo: :fake_repo } }

  describe "injection" do
    it 'adds .with method' do
      expect(klass).not_to respond_to :with

      klass.include InjectContext::Injection.new

      expect(klass).to respond_to :with

      builder = klass.with(context)

      expect(builder).to be_instance_of InjectContext::InstanceBuilder
      expect(builder.klass).to eq klass
      expect(builder.context).to eq context
    end

    it 'defines access methods' do
      klass.include InjectContext::Injection.new(:repo)

      instance = klass.with(context).new

      expect(instance).to respond_to :repo
      expect(instance.repo).to eq :fake_repo
    end
  end
end
