# Formula template for the external Homebrew tap
# (original-solutions/homebrew-livepane → Formula/livepane.rb).
#
# After each GitHub Release of livepane:
#   1. Set 0.4.0 (no leading "v"; matches GoReleaser {{ .Version }}).
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
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.4.0/livepane_0.4.0_darwin_arm64.tar.gz"
      sha256 "c3a1e68e2a18ce0eafa8c228b41b6c8e88a57ae5d65ac04bd26f46aea20e4ac1"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.4.0/livepane_0.4.0_darwin_amd64.tar.gz"
      sha256 "229e7123f3fb8a8db32d0589eee14fb00055d7ac07cce1bce73c10e18df7b2a7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.4.0/livepane_0.4.0_linux_arm64.tar.gz"
      sha256 "62225c0f2455ca860dba0478b86468ad0697827cb1f5ac0f115ea9b8d282cc51"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.4.0/livepane_0.4.0_linux_amd64.tar.gz"
      sha256 "6ac0ec020ddb8c31aa3bc885c378bc18904077588b62de8cd01b5bff525d6e76"
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
