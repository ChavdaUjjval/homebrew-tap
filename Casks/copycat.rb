cask "copycat" do
  version "1.1.0"
  sha256 "24741779596a4fcd6e927c9593a722ce0b69efad522ea7b465a566fe0de5334c"

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
