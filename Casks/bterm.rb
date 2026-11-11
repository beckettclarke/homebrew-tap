cask "bterm" do
  version "1.0.0"
  sha256 "e4a21efa0f79bcdf4bda67e3c5a1a6486129d70ace5e81bbaa4e32a8c2f7341e"

  url "https://github.com/beckettclarke/bterm/releases/download/v#{version}/bterm.zip"
  name "bterm"
  desc "Small, fast, native terminal"
  homepage "https://beckettclarke.github.io/bterm/"

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
