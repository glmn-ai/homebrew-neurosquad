# NeuroSquad Homebrew tap

[NeuroSquad](https://neurosquad.ai/) for macOS (Apple silicon and Intel, macOS 12 or newer).

```bash
brew install --cask glmn-ai/neurosquad/neurosquad
```

**Available after the first macOS release.** Until then the cask is disabled
and `brew install` says so; use the download page instead:
<https://neurosquad.ai/download>.

## Notes

- The app is signed with NeuroSquad's own certificate but **not notarized by
  Apple**. The cask removes the quarantine flag from the installed
  `NeuroSquad.app` after installing it, so macOS opens it without the
  "damaged" / "unidentified developer" dialog. This is why NeuroSquad lives in
  its own tap and not in the main Homebrew cask repository.
- NeuroSquad updates itself (`auto_updates true`), so `brew upgrade` skips it
  unless you pass `--greedy`.
- `brew uninstall --zap --cask neurosquad` also removes its settings and data
  (`~/Library/Application Support/NeuroSquad`).

Other ways to install: `curl -fsSL https://neurosquad.ai/install.sh | bash`,
or the `.dmg` from <https://neurosquad.ai/download>.

The cask is generated from the NeuroSquad release pipeline; changes made here
by hand are overwritten on the next release.
