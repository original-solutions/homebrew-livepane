# Formula template for the external Homebrew tap
# (original-solutions/homebrew-livepane → Formula/agent.rb).
#
# Install: brew install original-solutions/livepane/agent
# Binary name inside each archive remains: livepane
#
# After each GitHub Release of livepane:
#   1. Set 0.16.1 (no leading "v"; matches GoReleaser {{ .Version }}).
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
  version "0.16.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.16.1/livepane_0.16.1_darwin_arm64.tar.gz"
      sha256 "8216f0909c572ed8757e14b862d04746a5c15e5c2bbe015fa8b881168c47a001"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.16.1/livepane_0.16.1_darwin_amd64.tar.gz"
      sha256 "09c0bca3d6e8fcaef309603fd6e682f4af6e6b4062618ee3b0470d2c41e69c90"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.16.1/livepane_0.16.1_linux_arm64.tar.gz"
      sha256 "0262324b7e9686d4110b73ad025e30969e86a1eeefddfc4ee17c99b2775b6c9e"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.16.1/livepane_0.16.1_linux_amd64.tar.gz"
      sha256 "faf1609b739a8196f0b6a694b9b1a2c7b359183aa324998538857f036452ef5b"
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
