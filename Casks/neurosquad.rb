# Homebrew cask for NeuroSquad (docs/deploy.md, "Homebrew tap").
# Lives in the tap repo glmn-ai/homebrew-neurosquad as Casks/neurosquad.rb:
#
#   brew install --cask glmn-ai/neurosquad/neurosquad
#
# Filled for each release and pushed to the tap with
#   node apps/desktop/scripts/homebrew-cask.mjs <version> --push
# (reads SHA256SUMS-mac.txt of release v<version>, drops the `disable!` line).
# The values below are placeholders until the first macOS release; until then
# `brew install` stops with the `disable!` message instead of a broken download.
#
# The url is the versioned (immutable) release asset, not neurosquad.ai/downloads
# or releases/latest: a pinned sha256 needs a URL whose bytes never change.
cask "neurosquad" do
  arch arm: "arm64", intel: "x64"

  version "0.1.214"
  sha256 arm:   "8b02ebaf69a5700a669996dd4d52de818ab0ac55895b2500a79a7ef80763fb30",
         intel: "bd2bd564192b294977fb5fc1030226dc6d6d24748870af0926f472b3adf43db3"

  url "https://github.com/glmn-ai/neurosquad-releases/releases/download/v#{version}/NeuroSquad-#{version}-#{arch}.zip",
      verified: "github.com/glmn-ai/neurosquad-releases/"
  name "NeuroSquad"
  desc "Canvas for AI coding agents: Claude Code, Codex, Gemini CLI and more side by side"
  homepage "https://neurosquad.ai/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app updates itself (main/updater.ts, main/macUpdate.ts).
  auto_updates true
  depends_on macos: :monterey

  app "NeuroSquad.app"

  # Not notarized (no Apple Developer ID; signed with our own self-signed
  # certificate): without this, Gatekeeper would call the quarantined download
  # "damaged". Homebrew 5 dropped `--no-quarantine` and disables such casks in
  # its main repository, which is why this lives in our own tap.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/NeuroSquad.app"],
                   must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/NeuroSquad",
    "~/Library/Logs/NeuroSquad",
    "~/Library/Preferences/com.neurosquad.app.plist",
    "~/Library/Saved Application State/com.neurosquad.app.savedState",
  ]
end
