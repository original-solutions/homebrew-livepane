# Formula template for the external Homebrew tap
# (original-solutions/homebrew-livepane → Formula/livepane.rb).
#
# After each GitHub Release of livepane:
#   1. Set 0.11.0 (no leading "v"; matches GoReleaser {{ .Version }}).
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
  version "0.11.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.11.0/livepane_0.11.0_darwin_arm64.tar.gz"
      sha256 "888342c7e09fb37a24dfc360514173a4a62027b63a397cd0d8dfb1694ca68943"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.11.0/livepane_0.11.0_darwin_amd64.tar.gz"
      sha256 "d1e6573f180f4b68e9bb33a8bb9b7e0df9f25b2602731efd908b2f2cfc91c3df"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.11.0/livepane_0.11.0_linux_arm64.tar.gz"
      sha256 "36a6317e4d68d1c2fceac90a9ccdcddd971e1163be69b5c09f9b73e56af853f3"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.11.0/livepane_0.11.0_linux_amd64.tar.gz"
      sha256 "6db9898f47f8a0e6077c2ec3f8fd8cabe24f020d966a37537eae2152f868b258"
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
