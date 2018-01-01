RSpec.describe Context do
  describe "version" do
    it { expect(Context::VERSION).not_to be nil }
  end

  describe "class method []" do
    it "creates new injection" do
      injection = double(:injection)

      expect(Context::Injection)
        .to receive(:new).with(:repo, logger: :app_logger).and_return(injection)

      expect(Context[:repo, logger: :app_logger]).to eq injection
    end
  end
end
