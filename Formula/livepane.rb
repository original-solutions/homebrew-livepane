# Formula template for the external Homebrew tap
# (original-solutions/homebrew-livepane → Formula/livepane.rb).
#
# After each GitHub Release of livepane:
#   1. Set 0.7.0 (no leading "v"; matches GoReleaser {{ .Version }}).
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
  version "0.7.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.7.0/livepane_0.7.0_darwin_arm64.tar.gz"
      sha256 "fb1fa34cff10e10c850e4632644a77d573fe412845e0a905976a1f9a777c581e"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.7.0/livepane_0.7.0_darwin_amd64.tar.gz"
      sha256 "80ae32f8aa0004bb4fb934be428615bf34499f4943936c02f4104846e566b6d5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.7.0/livepane_0.7.0_linux_arm64.tar.gz"
      sha256 "e20f086a4f6f77c64651686881cc3f5cf42d90f7871b12fc0c24cc3c693e28ca"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.7.0/livepane_0.7.0_linux_amd64.tar.gz"
      sha256 "c7da6e141b01d5af7d62884c4eebcb0bea23e362a9836bb217bd7bf5da4a094d"
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
