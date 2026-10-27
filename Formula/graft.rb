# Written by update.py from the latest release of lydakis/graft; edit that, not this.
class Graft < Formula
  desc "Many cheap copies of a GitHub repository or folder for parallel agents"
  homepage "https://github.com/lydakis/graft"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/lydakis/graft/releases/download/v0.2.0/graft-aarch64-apple-darwin.tar.gz"
      sha256 "773f94ea2bf96e9c36c31058b25ab0d56da83daadf01e9a9e75d5fe6acfdeb14"
    end
    on_intel do
      url "https://github.com/lydakis/graft/releases/download/v0.2.0/graft-x86_64-apple-darwin.tar.gz"
      sha256 "d49eed97ae8bccca3f37181788eaf3fcae3f408e312a415d8d0ec417a52163d5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lydakis/graft/releases/download/v0.2.0/graft-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0afa9b6ab20e6c273a916d209fc94099c9020e1ae4fe66262e53c1c2b64ded0f"
    end
    on_intel do
      url "https://github.com/lydakis/graft/releases/download/v0.2.0/graft-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2c5edcd506ea64535a6323d1b224e8ec0bd3edcfb3bcb384765146ae01a9c3b4"
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
