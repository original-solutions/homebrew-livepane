# Formula template for the external Homebrew tap
# (original-solutions/homebrew-livepane → Formula/livepane.rb).
#
# After each GitHub Release of livepane:
#   1. Set 0.3.0 (no leading "v"; matches GoReleaser {{ .Version }}).
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
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.3.0/livepane_0.3.0_darwin_arm64.tar.gz"
      sha256 "0f50298a223da52c78aad2a3f2b77906b51d25ff9cbd1279924dfa1cfe8eefc2"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.3.0/livepane_0.3.0_darwin_amd64.tar.gz"
      sha256 "ca6be45284e7d0441759fe2edb66d9825f80f4c71250e2ddd123ac6cae9d0edf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.3.0/livepane_0.3.0_linux_arm64.tar.gz"
      sha256 "983894e6dc345a29714e5d3fa94d9fd7bc385f57ca17a6cbaae3c03770fa71cb"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.3.0/livepane_0.3.0_linux_amd64.tar.gz"
      sha256 "6a45f4d40982c095ad8c95d299f686050e1d857f2ff0987372e478b02ac98470"
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
