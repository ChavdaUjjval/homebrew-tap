cask "copycat" do
  version "1.0.2"
  sha256 "26f33a7d20d8f0991f086febb7f85c39161eeab9b11092945519bfc758f9248f"

  url "https://github.com/ChavdaUjjval/copycat/releases/download/v#{version}/Copycat.dmg"
  name "Copycat"
  desc "Clipboard history that lives in the Dock"
  homepage "https://github.com/ChavdaUjjval/copycat"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Copycat.app"

  # Copycat isn't notarized, so clear the download flag that would make macOS block it.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Copycat.app"]
  end

  uninstall quit: "com.ujjvalchavda.copycat"

  zap trash: [
    "~/Library/Application Support/Copycat",
    "~/Library/Preferences/com.ujjvalchavda.copycat.plist",
  ]
end
