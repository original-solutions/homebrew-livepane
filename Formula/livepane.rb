# Formula template for the external Homebrew tap
# (original-solutions/homebrew-livepane → Formula/livepane.rb).
#
# After each GitHub Release of livepane:
#   1. Set 0.6.0 (no leading "v"; matches GoReleaser {{ .Version }}).
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
  version "0.6.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.6.0/livepane_0.6.0_darwin_arm64.tar.gz"
      sha256 "a9f51293fbce4bb9696c4cd81a8463e4f99f27973e2f8ca014e48056e92ac9e5"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.6.0/livepane_0.6.0_darwin_amd64.tar.gz"
      sha256 "0c9952fbd88a7ef6531f5d5fa9e7cf06ebffb0acdc9aac8caaf90712b44e20ff"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.6.0/livepane_0.6.0_linux_arm64.tar.gz"
      sha256 "a5dca12d7874edb92373f36ce70edef8e4b4fa9a911bd27205535f293a190271"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.6.0/livepane_0.6.0_linux_amd64.tar.gz"
      sha256 "d9c64c292ddca5c3350820084c34edc8f2d1b89d6bc72461e325af88da273b96"
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
