# Formula template for the external Homebrew tap
# (original-solutions/homebrew-livepane → Formula/agent.rb).
#
# Install: brew install original-solutions/livepane/agent
# Binary name inside each archive remains: livepane
#
# After each GitHub Release of livepane:
#   1. Set 0.14.0 (no leading "v"; matches GoReleaser {{ .Version }}).
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
  version "0.14.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.14.0/livepane_0.14.0_darwin_arm64.tar.gz"
      sha256 "b215ded6247a5b1fe7b6cc243c2a1dc51092f6dd155c04e3be57de3c4a3518d9"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.14.0/livepane_0.14.0_darwin_amd64.tar.gz"
      sha256 "61456dbe1be80736de2ee2db7e1423a9be924ef296bcd8c3ea0e9ddec930b09c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.14.0/livepane_0.14.0_linux_arm64.tar.gz"
      sha256 "3c27a059757bba576d58dde70912df413ec46a50e6515412749e09bee3bf27a0"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.14.0/livepane_0.14.0_linux_amd64.tar.gz"
      sha256 "a44aeea01ddf4823cc043dfc63b8a51d07984be4ffb13f181752a16de77333dc"
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
