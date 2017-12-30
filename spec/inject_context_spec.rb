RSpec.describe InjectContext do
  describe "version" do
    it { expect(InjectContext::VERSION).not_to be nil }
  end

  describe "class method []" do
    it "creates new injection" do
      injection = double(:injection)

      expect(InjectContext::Injection)
        .to receive(:new).with(:repo, logger: :app_logger).and_return(injection)

      expect(InjectContext[:repo, logger: :app_logger]).to eq injection
    end
  end
end
