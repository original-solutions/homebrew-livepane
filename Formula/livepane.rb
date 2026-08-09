# Formula template for the external Homebrew tap
# (original-solutions/homebrew-livepane → Formula/livepane.rb).
#
# After each GitHub Release of livepane:
#   1. Set 0.2.0 (no leading "v"; matches GoReleaser {{ .Version }}).
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
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.2.0/livepane_0.2.0_darwin_arm64.tar.gz"
      sha256 "7ee364bf4f26847ca8dc5ec338534970a7059469c9ede583317cf06602dfa673"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.2.0/livepane_0.2.0_darwin_amd64.tar.gz"
      sha256 "d25b20e3e0a597d24e3d11d28b834301dcd1efd9637b2dc41f1ef6ab54bc27ae"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.2.0/livepane_0.2.0_linux_arm64.tar.gz"
      sha256 "e18d784bb6faf94d8b6d46a4d8ed6fadbe09d7cc9e46312f278d91b1206dd13b"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.2.0/livepane_0.2.0_linux_amd64.tar.gz"
      sha256 "e7362addc79d2902f3c5e46f34f350744564353326b024ca9d832803e61bcb9b"
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
