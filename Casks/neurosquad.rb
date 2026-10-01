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

  version "0.1.218"
  sha256 arm:   "bbbfd81f0c2bf3e896c71edeba174f41238e642ee11d44c8c4868e6087f3e332",
         intel: "f79c9613058667fb99eee84bda35a4de4b6959d7549db034b38c223b519ad5c8"

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

  # Since 0.1.218 the app is Developer ID-signed and notarized, so Gatekeeper
  # accepts it even quarantined (it would only ask the usual "downloaded from
  # the Internet — Open?" once). Removing the flag keeps a Homebrew install
  # opening with no prompt at all, as before. It was required for 0.1.214
  # (self-signed, not notarized) — Homebrew 5 dropped `--no-quarantine` and
  # disables such casks in its main repository, hence our own tap.
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
