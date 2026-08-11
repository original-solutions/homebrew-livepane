# Formula template for the external Homebrew tap
# (original-solutions/homebrew-livepane → Formula/livepane.rb).
#
# After each GitHub Release of livepane:
#   1. Set 0.12.0 (no leading "v"; matches GoReleaser {{ .Version }}).
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
  version "0.12.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.12.0/livepane_0.12.0_darwin_arm64.tar.gz"
      sha256 "ad719e1b3bd9253eb0efad5272efb337b3d1aef455315d6f83c2cde44306d0ad"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.12.0/livepane_0.12.0_darwin_amd64.tar.gz"
      sha256 "834a6cb611a048111f110942f4716e7f6436d1af165424b7d5611a861a002398"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.12.0/livepane_0.12.0_linux_arm64.tar.gz"
      sha256 "c2299f37656d8f46d8ecdcf7517a585b727b049a6c561f08781c40b780cd66f5"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.12.0/livepane_0.12.0_linux_amd64.tar.gz"
      sha256 "a6978076192991a78a75c85e90f53f5a469cbeea2da061c2e58ad65dffff8996"
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
