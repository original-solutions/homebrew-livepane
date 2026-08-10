# Formula template for the external Homebrew tap
# (original-solutions/homebrew-livepane → Formula/livepane.rb).
#
# After each GitHub Release of livepane:
#   1. Set 0.5.0 (no leading "v"; matches GoReleaser {{ .Version }}).
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
  version "0.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.5.0/livepane_0.5.0_darwin_arm64.tar.gz"
      sha256 "24b24adf3e87d5cb37c8c0b425de3b50b854a7d5dd77556e4d1ad10866bc7a99"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.5.0/livepane_0.5.0_darwin_amd64.tar.gz"
      sha256 "ce80c4e2016f91d708211e395cf2bf9d4695b0f1971e7f5bf99080fd5f0387ae"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.5.0/livepane_0.5.0_linux_arm64.tar.gz"
      sha256 "397ddfdd8f359098cfb8e2338eaaca3f01fe131059375b9b4315f16e3c7a5f15"
    end
    on_intel do
      url "https://github.com/original-solutions/livepane-agent/releases/download/v0.5.0/livepane_0.5.0_linux_amd64.tar.gz"
      sha256 "51a4a229f9363af924cbfc674923a900b5d4e8276fc642086e1b36858afef690"
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
