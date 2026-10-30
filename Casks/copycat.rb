cask "copycat" do
  version "1.1.2"
  sha256 "36ebd58e8434594b80adfa09db111494677ad8df60236dee74b63bf97c372cd9"

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
