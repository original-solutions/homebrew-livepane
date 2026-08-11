# Formula template for the external Homebrew tap
# (original-solutions/homebrew-livepane → Formula/livepane.rb).
#
# After each GitHub Release of livepane:
#   1. Set 0.8.0 (no leading "v"; matches GoReleaser {{ .Version }}).
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
  version "0.8.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.8.0/livepane_0.8.0_darwin_arm64.tar.gz"
      sha256 "c8399daa4c36dfed25ca5cc186084b8a06ad04d19fa1f2574cc3aa1e8878d673"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.8.0/livepane_0.8.0_darwin_amd64.tar.gz"
      sha256 "80631492a098e39920fb2d199632e9676e52f84ada71c54c1da75259101f5ff6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.8.0/livepane_0.8.0_linux_arm64.tar.gz"
      sha256 "11bf46fa3d6ec5b06d672185e282db9bc4157db8dfcdb8418b0e38eaed8db8e5"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.8.0/livepane_0.8.0_linux_amd64.tar.gz"
      sha256 "2295194cd828fd8852d7b5d447a63bf04d991845e95fbd84d7a62a6999121ad5"
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
