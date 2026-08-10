# Formula template for the external Homebrew tap
# (original-solutions/homebrew-livepane → Formula/livepane.rb).
#
# After each GitHub Release of livepane:
#   1. Set 0.5.1 (no leading "v"; matches GoReleaser {{ .Version }}).
#   2. Fill the four SHA256 placeholders from release checksums.txt.
#   3. Copy this file into the tap repo as Formula/livepane.rb (strip this header if desired).
#
# Archive names match monorepo .goreleaser.yaml:
#   livepane_{Version}_{Os}_{Arch}.tar.gz
# Binary name inside each archive: livepane
#
# Supervisor: prefer product `livepane install-service` over `brew services`
# so launchd/systemd units stay under product control (avoids double registration).

class Livepane < Formula
  desc "LivePane machine agent — claim, heartbeat, stream terminal panes"
  homepage "https://livepane.io"
  version "0.5.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.5.1/livepane_0.5.1_darwin_arm64.tar.gz"
      sha256 "f97c7e7bda2f83643b8fb8416c47b9a39b546265a0ca9b477ba88a9f559fc32d"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.5.1/livepane_0.5.1_darwin_amd64.tar.gz"
      sha256 "cd487234f46981b80e8d8ea50a1ed3cf52c8e12ca8e3dd1f49e5b757ad2d4f64"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.5.1/livepane_0.5.1_linux_arm64.tar.gz"
      sha256 "3a18152a8ba494534f7be036f9ffe3199f5f5a685817fbf6e6bdffc9b651e896"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.5.1/livepane_0.5.1_linux_amd64.tar.gz"
      sha256 "4c2f41eebdf146f2feeb9de7f38fd2eb572b2ecd6f4bd1a2b8014b99888a788c"
    end
  end

  def install
    bin.install "livepane"
  end

  # Optional Homebrew service (alternate). Product path is preferred:
  #   livepane install-service
  # Do not enable both brew services and install-service on the same machine.
  # service do
  #   run [opt_bin/"livepane", "run"]
  #   keep_alive true
  # end

  test do
    assert_match version.to_s, shell_output("#{bin}/livepane version")
  end
end
