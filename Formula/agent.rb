# Formula template for the external Homebrew tap
# (original-solutions/homebrew-livepane → Formula/agent.rb).
#
# Install: brew install original-solutions/livepane/agent
# Binary name inside each archive remains: livepane
#
# After each GitHub Release of livepane:
#   1. Set 0.15.0 (no leading "v"; matches GoReleaser {{ .Version }}).
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
  version "0.15.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.15.0/livepane_0.15.0_darwin_arm64.tar.gz"
      sha256 "ec8409ca1117266e1ae68cb2f137ced4813f69b1a73493002c28e8e51c2e499f"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.15.0/livepane_0.15.0_darwin_amd64.tar.gz"
      sha256 "b9df9fa8a11fd7d61584efd0e543e8ca142980ab16107ead1a5d8dfec36197b3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.15.0/livepane_0.15.0_linux_arm64.tar.gz"
      sha256 "8d3993d746b7d8a177716cbe20e7353b7c752a26863f77a09d117e4b0a055444"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.15.0/livepane_0.15.0_linux_amd64.tar.gz"
      sha256 "6013f9ed6dc7dc9083c5585773067aa55546212fd25e1fb29222231c3e58d2f0"
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
