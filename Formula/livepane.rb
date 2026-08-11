# Formula template for the external Homebrew tap
# (original-solutions/homebrew-livepane → Formula/livepane.rb).
#
# After each GitHub Release of livepane:
#   1. Set 0.10.0 (no leading "v"; matches GoReleaser {{ .Version }}).
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
  version "0.10.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.10.0/livepane_0.10.0_darwin_arm64.tar.gz"
      sha256 "e8d39f73e05095cb2e26c7efe48e680ff31d380d2444f8d289e23f8a0799f50d"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.10.0/livepane_0.10.0_darwin_amd64.tar.gz"
      sha256 "c1ee2bbc40c068b05bfd23e7e08ab1e75f63ee3fd42624cfa883c30e318e728e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.10.0/livepane_0.10.0_linux_arm64.tar.gz"
      sha256 "27ea2870da2a24b3e9a77babf5a91673f7ea9fb358a2d70910cc9b6bb9384b88"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.10.0/livepane_0.10.0_linux_amd64.tar.gz"
      sha256 "a9a6aa4415f6dc4c935a8d0eb7dfa4503bde2061332eda0c7a1037d5d84db39a"
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
