cask "jldb" do
  version "0.2.13"
  sha256 "4d012db1cbbb4923820ebaac1f7d8911dd5beec5b1d04823ddbe2b8c3143826c"

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
