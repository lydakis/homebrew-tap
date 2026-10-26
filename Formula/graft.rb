# Written by update.py from the latest release of lydakis/graft; edit that, not this.
class Graft < Formula
  desc "Many cheap copies of a GitHub repository or folder for parallel agents"
  homepage "https://github.com/lydakis/graft"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/lydakis/graft/releases/download/v0.1.0/graft-aarch64-apple-darwin.tar.gz"
      sha256 "ab545f72f8d47c754ffc5eda630bfdadf5245b0adaf77d912f396e636f0e338e"
    end
    on_intel do
      url "https://github.com/lydakis/graft/releases/download/v0.1.0/graft-x86_64-apple-darwin.tar.gz"
      sha256 "247f0df7ef547f48fd2e7be5c1288f90f532cd31e656db4dbcae9a291df263a4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lydakis/graft/releases/download/v0.1.0/graft-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6e3a7630061cb37aaba10888082214d7c9ce2e73dda3e589878612dee087fa5b"
    end
    on_intel do
      url "https://github.com/lydakis/graft/releases/download/v0.1.0/graft-x86_64-unknown-linux-musl.tar.gz"
      sha256 "16e20c9b66e5b4a2d698f9db76a31e1f3ec350fdd02bd86a0bdf7f2f90d1683c"
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
