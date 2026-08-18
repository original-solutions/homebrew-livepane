# Formula template for the external Homebrew tap
# (original-solutions/homebrew-livepane → Formula/agent.rb).
#
# Install: brew install original-solutions/livepane/agent
# Binary name inside each archive remains: livepane
#
# After each GitHub Release of livepane:
#   1. Set 0.13.1 (no leading "v"; matches GoReleaser {{ .Version }}).
#   2. Fill the four SHA256 placeholders from release checksums.txt.
#   3. Copy this file into the tap repo as Formula/agent.rb (strip this header if desired).
#
# Archive names match monorepo .goreleaser.yaml:
#   livepane_{Version}_{Os}_{Arch}.tar.gz
#
# Supervisor: prefer product `livepane install-service` over `brew services`
# so launchd/systemd units stay under product control (avoids double registration).

class Agent < Formula
  desc "LivePane machine agent — claim, heartbeat, stream terminal panes"
  homepage "https://livepane.io"
  version "0.13.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.13.1/livepane_0.13.1_darwin_arm64.tar.gz"
      sha256 "f8b7727d0dd0c19dd32c3abf4154cbd006eb6ab067d32d7100444e2d137e0503"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.13.1/livepane_0.13.1_darwin_amd64.tar.gz"
      sha256 "4622e2785aa4750fed4e74bdce028ac5018beb97776d9dc6287db4e49f0dede4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.13.1/livepane_0.13.1_linux_arm64.tar.gz"
      sha256 "7e44d23b2823ffa2ebb32ae74d44aa2331fcf91422b772804175da22ceb95f10"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.13.1/livepane_0.13.1_linux_amd64.tar.gz"
      sha256 "370e0e016ee7163c57bce4190c1f0952d5519ab8e96e92c2549bfd5d9e7264d2"
    end
  end

  def install
    bin.install "livepane"
  end

  def caveats
    <<~EOS
      The Homebrew formula is original-solutions/livepane/agent (binary: livepane).
      If you previously installed the old formula name:
        brew uninstall livepane
        brew install original-solutions/livepane/agent
    EOS
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
