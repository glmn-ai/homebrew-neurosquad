# NeuroSquad Homebrew tap

[NeuroSquad](https://neurosquad.ai/) for macOS (Apple silicon and Intel, macOS 12 or newer).

```bash
brew install --cask glmn-ai/neurosquad/neurosquad
```

## Notes

- Since version 0.1.218 the app is signed with an Apple Developer ID and
  notarized by Apple. The cask also removes the quarantine flag from the
  installed `NeuroSquad.app`, so it opens without even macOS's one-time
  "downloaded from the Internet" question. (Earlier builds were not notarized,
  which is why NeuroSquad has its own tap.)
- NeuroSquad updates itself (`auto_updates true`), so `brew upgrade` skips it
  unless you pass `--greedy`.
- `brew uninstall --zap --cask neurosquad` also removes its settings and data
  (`~/Library/Application Support/NeuroSquad`).

Other ways to install: `curl -fsSL https://neurosquad.ai/install.sh | bash`,
or the `.dmg` from <https://neurosquad.ai/download>.

The cask is generated from the NeuroSquad release pipeline; changes made here
by hand are overwritten on the next release.
