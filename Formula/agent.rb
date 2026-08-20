# Formula template for the external Homebrew tap
# (original-solutions/homebrew-livepane → Formula/agent.rb).
#
# Install: brew install original-solutions/livepane/agent
# Binary name inside each archive remains: livepane
#
# After each GitHub Release of livepane:
#   1. Set 0.16.0 (no leading "v"; matches GoReleaser {{ .Version }}).
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
  version "0.16.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.16.0/livepane_0.16.0_darwin_arm64.tar.gz"
      sha256 "e7e44045cf05ff126e82d83a591dc20ae583071e978d6e2bfdb58c568f1c4228"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.16.0/livepane_0.16.0_darwin_amd64.tar.gz"
      sha256 "e6879cf1b8339d068730e26dad3d9ddba8c3e1fee87ae58866de0d2833a2390a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.16.0/livepane_0.16.0_linux_arm64.tar.gz"
      sha256 "9635670a579437889adcd2a2510d1fb8b31ec996612866ca1ba2c7beacf2df3f"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.16.0/livepane_0.16.0_linux_amd64.tar.gz"
      sha256 "2c84e131b1cd7043bba0eee408e4cd3e55d0174b372cc586a274f922bd6ab808"
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
