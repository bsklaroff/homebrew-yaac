# Source of truth for the bsklaroff/homebrew-yaac tap (see ../README.md for
# the release/sync flow). The desktop app alone: it runs the yaac-server
# formula's CLI for any server on this Mac, so the server code has one copy.
# No auto_updates: the app has no updater, and `brew upgrade` moves it and
# the formula together.
cask "yaac-desktop" do
  version "0.1.2"
  # Printed by `pnpm desktop:release`; recompute with shasum -a 256 <dmg>
  sha256 "034961a88174bc0589e8db4427abb7234a29e776f986c0ddbdefcccc62623912"

  url "https://github.com/bsklaroff/yaac/releases/download/v#{version}/yaac-#{version}-arm64.dmg"
  name "yaac"
  desc "Desktop app for the yaac agent sandbox manager"
  homepage "https://github.com/bsklaroff/yaac"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on formula: "bsklaroff/yaac/yaac-server"

  app "yaac.app"

  # Not ~/.yaac-server, ~/.yaac-cluster or ~/.yaac-client: those are the servers'
  # data and their registration, which the formula's CLI owns.
  zap trash: [
    "~/Library/Application Support/yaac",
    "~/Library/Preferences/com.bsklaroff.yaac.plist",
  ]
end
