# Written by update.py from the latest release of lydakis/sandfs; edit that, not this.
class Sandfs < Formula
  desc "Copy-on-write workspaces over folders and git repositories, mounted as folders"
  homepage "https://github.com/lydakis/sandfs"
  version "0.9.0"
  license all_of: ["MIT", "BSD-3-Clause"]

  on_macos do
    on_arm do
      url "https://github.com/lydakis/sandfs/releases/download/v0.9.0/sandfs-aarch64-apple-darwin.tar.gz"
      sha256 "95ad8ffe7124492c900257e237f555d60c3e9d88e47c50fa3417a5082ce24bc8"
    end
    on_intel do
      url "https://github.com/lydakis/sandfs/releases/download/v0.9.0/sandfs-x86_64-apple-darwin.tar.gz"
      sha256 "03373aa04b26b1c2295d6f8ed2c60b7903833c9403ba5e2d34da316fd07ab561"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lydakis/sandfs/releases/download/v0.9.0/sandfs-aarch64-unknown-linux-musl.tar.gz"
      sha256 "264971dbec4ad531e2ad6e5de793a42a5f7f2b74cb809908130bce86ae619b58"
    end
    on_intel do
      url "https://github.com/lydakis/sandfs/releases/download/v0.9.0/sandfs-x86_64-unknown-linux-musl.tar.gz"
      sha256 "cd2d03e6d7c615171d11f6a603f8a960a6c17747001dc16027ae6dd9d3d59ac7"
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
