# Formula template for the external Homebrew tap
# (original-solutions/homebrew-livepane → Formula/livepane.rb).
#
# After each GitHub Release of livepane:
#   1. Set 0.9.0 (no leading "v"; matches GoReleaser {{ .Version }}).
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
  version "0.9.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.9.0/livepane_0.9.0_darwin_arm64.tar.gz"
      sha256 "8bd747014d82273138b15aae98d79a2520c00e40b0b472d05886b2283cd94290"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.9.0/livepane_0.9.0_darwin_amd64.tar.gz"
      sha256 "f10529244e6bde748b040537801c2cff79bb06d34bc3bc17ba103edc43f43dfc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.9.0/livepane_0.9.0_linux_arm64.tar.gz"
      sha256 "3ab384746cebe7a459bcf3362d1c645e89853cb86bc7fbb8c434f9848124c5f8"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.9.0/livepane_0.9.0_linux_amd64.tar.gz"
      sha256 "735a6fd2dbb5e0d1f9bdf1db5f2d27bc007b7cfc57b983fe6c178d1f8709cda5"
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
