# Written by update.py from the latest release of lydakis/graft; edit that, not this.
class Graft < Formula
  desc "Many cheap copies of a GitHub repository or folder for parallel agents"
  homepage "https://github.com/lydakis/graft"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/lydakis/graft/releases/download/v0.3.0/graft-aarch64-apple-darwin.tar.gz"
      sha256 "977a2f76bd97856dba44f9eb0fe1156f3858e15d81e95175c81cbdb839721c62"
    end
    on_intel do
      url "https://github.com/lydakis/graft/releases/download/v0.3.0/graft-x86_64-apple-darwin.tar.gz"
      sha256 "c0af7b4ecab79f9c7e3b2e4fb6c279625c8f94a2218c53d15aa887142bd640a8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lydakis/graft/releases/download/v0.3.0/graft-aarch64-unknown-linux-musl.tar.gz"
      sha256 "562754867949f20ef047968a374d7aed64cfb8f5f4144fe93ca0d2845367cbaa"
    end
    on_intel do
      url "https://github.com/lydakis/graft/releases/download/v0.3.0/graft-x86_64-unknown-linux-musl.tar.gz"
      sha256 "cde9a325967f702e6fff5ab54a772ddc1f6613576ceedb270c12ad7a88727e8d"
    end
  end

  def install
    bin.install "gft", "graft"
  end

  def caveats
    "On Linux, mounts need FUSE 3 (the fuse3 package)." if OS.linux?
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gft --version")
  end
end
