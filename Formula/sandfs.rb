# Written by update.py from the latest release of lydakis/sandfs; edit that, not this.
class Sandfs < Formula
  desc "Copy-on-write workspaces over folders and git repositories, mounted as folders"
  homepage "https://github.com/lydakis/sandfs"
  version "0.7.0"
  license all_of: ["MIT", "BSD-3-Clause"]

  on_macos do
    on_arm do
      url "https://github.com/lydakis/sandfs/releases/download/v0.7.0/sandfs-aarch64-apple-darwin.tar.gz"
      sha256 "e2fc6bff2d914ee3cfcb50bb5f6fe1772d2b9912e586d25fd9dd063db96c825b"
    end
    on_intel do
      url "https://github.com/lydakis/sandfs/releases/download/v0.7.0/sandfs-x86_64-apple-darwin.tar.gz"
      sha256 "808881c56f6d686aed9ef69000bd79e3d0ad0004dcc3337f237f3e489f7bf2e4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lydakis/sandfs/releases/download/v0.7.0/sandfs-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c6e040743e125a3ec1bd6f85f4768e3b6a9ebdf564734f8ec0ff43e2fb444399"
    end
    on_intel do
      url "https://github.com/lydakis/sandfs/releases/download/v0.7.0/sandfs-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7d487f0eb67ff6cff12ed3706bd24c4f4dceb6a0ef78c9bd838a197d17b196d3"
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
