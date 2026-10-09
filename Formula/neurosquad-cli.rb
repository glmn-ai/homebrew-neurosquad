class NeurosquadCli < Formula
  desc "Run several AI coding agents in your terminal and get called when one needs you"
  homepage "https://github.com/glmn-ai/neurosquad-cli"
  url "https://registry.npmjs.org/neurosquad/-/neurosquad-0.1.0.tgz"
  sha256 "7e3a2e3e055b29506fd36f8d803d218d7402b5f27072473c2989d6298daf418c"
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
