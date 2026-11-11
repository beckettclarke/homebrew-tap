cask "bterm" do
  version "1.0.0"
  sha256 "cae45ab08c3f4edcee37d737aaf65471b6fe1048fcc1ca937b883a3d324bea9f"

  url "https://github.com/beckettclarke/bterm/releases/download/v#{version}/bterm.zip"
  name "bterm"
  desc "Small, fast, native terminal"
  homepage "https://term.beckettclarke.ca/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "bterm.app"

  # bterm releases are ad-hoc signed, not notarized. Clearing the quarantine flag lets
  # the app open without the "can't be checked for malicious software" prompt.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/bterm.app"],
        writable_paths: ["{{appdir}}/bterm.app"],
        must_succeed:   false
  end

  zap trash: [
    "~/Library/Preferences/dev.bterm.app.plist",
    "~/Library/Saved Application State/dev.bterm.app.savedState",
  ]
end
