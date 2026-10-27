# Written by update.py from the latest release of lydakis/sandfs; edit that, not this.
class Sandfs < Formula
  desc "Copy-on-write workspaces over folders and git repositories, mounted as folders"
  homepage "https://github.com/lydakis/sandfs"
  version "0.8.0"
  license all_of: ["MIT", "BSD-3-Clause"]

  on_macos do
    on_arm do
      url "https://github.com/lydakis/sandfs/releases/download/v0.8.0/sandfs-aarch64-apple-darwin.tar.gz"
      sha256 "d25ec81251f7f1fbc970ef229b7effe15a3fabe5dc291277223f93603cfd4a18"
    end
    on_intel do
      url "https://github.com/lydakis/sandfs/releases/download/v0.8.0/sandfs-x86_64-apple-darwin.tar.gz"
      sha256 "5272be26608c1b1e1387be7bd0bfa7c990a9c709307bb972c68271e05143da3c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lydakis/sandfs/releases/download/v0.8.0/sandfs-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5062871dc2fef34c315fbba76ede35866c3042d1fbbe2216e9a0c4603b79bd7e"
    end
    on_intel do
      url "https://github.com/lydakis/sandfs/releases/download/v0.8.0/sandfs-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1fc487481221667781d6fad3acd50ba303e4a435d5d6cfb4ded86954596c137c"
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
