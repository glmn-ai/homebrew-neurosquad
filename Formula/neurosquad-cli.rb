class NeurosquadCli < Formula
  desc "Run several AI coding agents in your terminal and get called when one needs you"
  homepage "https://github.com/glmn-ai/neurosquad-cli"
  url "https://registry.npmjs.org/neurosquad/-/neurosquad-0.0.0-placeholder.tgz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/neurosquad/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  depends_on "node"

  def install
    # std_npm_args installs with --ignore-scripts: every native addon nsq uses must come from a
    # prebuild (CI's pack smoke checks exactly this install mode on macOS and Linux).
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/nsq --version")
  end
end
