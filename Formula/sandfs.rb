# Written by update.py from the latest release of lydakis/sandfs; edit that, not this.
class Sandfs < Formula
  desc "Copy-on-write workspaces over folders and git repositories, mounted as folders"
  homepage "https://github.com/lydakis/sandfs"
  version "0.7.1"
  license all_of: ["MIT", "BSD-3-Clause"]

  on_macos do
    on_arm do
      url "https://github.com/lydakis/sandfs/releases/download/v0.7.1/sandfs-aarch64-apple-darwin.tar.gz"
      sha256 "c85f24fe038083326ea6d2148d5e4676eae572ce7d4df0d7b1668f4e854923a5"
    end
    on_intel do
      url "https://github.com/lydakis/sandfs/releases/download/v0.7.1/sandfs-x86_64-apple-darwin.tar.gz"
      sha256 "2feecdbfe4b5c27368140bd43f4584d3fa9f30e573d2e79d22b90e8ff6acd592"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lydakis/sandfs/releases/download/v0.7.1/sandfs-aarch64-unknown-linux-musl.tar.gz"
      sha256 "82272820369f8c7225658e8ffe8e8f527e7e700c5086355c3b84f0698942a7c9"
    end
    on_intel do
      url "https://github.com/lydakis/sandfs/releases/download/v0.7.1/sandfs-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b8e903d02fc064907c33a9c2b3dc83751012f64fa6d4f3d1471445e7cd91559d"
    end
  end

  def install
    bin.install "sandfs"
  end

  def caveats
    "On Linux, mounts need FUSE 3 (the fuse3 package)." if OS.linux?
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sandfs --version")
  end
end
