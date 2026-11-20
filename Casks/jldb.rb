cask "jldb" do
  version "0.2.26"
  sha256 "74532ed1bdf17b450e79ee287a8a643a94363048f97cfad66006963cc1f8cf68"

  # The source lives in a private repository; installers are published from this public one.
  url "https://github.com/jonathanleivag/jldb-releases/releases/download/v#{version}/JLDB-#{version}-arm64.dmg"
  name "JLDB"
  desc "Database client with environment folders and production write protection"
  homepage "https://github.com/jonathanleivag/jldb-releases"

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "JLDB.app"

  # The app is not signed with an Apple Developer ID, so Gatekeeper would block it on first launch.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "/Applications/JLDB.app"],
        must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/jldb",
    "~/Library/Application Support/JLDB",
    "~/Library/Preferences/cl.jonathanleivag.jldb.plist",
    "~/Library/Saved Application State/cl.jonathanleivag.jldb.savedState",
  ]
end
