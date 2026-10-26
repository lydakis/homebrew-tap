#!/usr/bin/env python3
"""Write each formula for its project's latest GitHub release.

The releases carry prebuilt archives named PROJECT-TARGET.tar.gz, and GitHub lists
each archive's sha256, so nothing is downloaded. Run with no arguments; set
GITHUB_TOKEN to avoid the API's limit for anonymous calls.
"""

import json
import os
import urllib.error
import pathlib
import urllib.request

TARGETS = {
    ("macos", "arm"): "aarch64-apple-darwin",
    ("macos", "intel"): "x86_64-apple-darwin",
    ("linux", "arm"): "aarch64-unknown-linux-musl",
    ("linux", "intel"): "x86_64-unknown-linux-musl",
}

FORMULAS = {
    "graft": {
        "class": "Graft",
        "repo": "lydakis/graft",
        "archive": "graft",
        "desc": "Many cheap copies of a GitHub repository or folder for parallel agents",
        "license": '"MIT"',
        "bins": ["gft", "graft"],
        "test": "gft",
        "caveats": "On Linux, mounts need FUSE 3 (the fuse3 package).",
    },
    "sandfs": {
        "class": "Sandfs",
        "repo": "lydakis/sandfs",
        "archive": "sandfs",
        "desc": "Copy-on-write workspaces over folders and git repositories, mounted as folders",
        "license": 'all_of: ["MIT", "BSD-3-Clause"]',
        "bins": ["sandfs"],
        "test": "sandfs",
        "caveats": "On Linux, mounts need FUSE 3 (the fuse3 package).",
    },
}


def latest(repo):
    request = urllib.request.Request(f"https://api.github.com/repos/{repo}/releases/latest")
    request.add_header("Accept", "application/vnd.github+json")
    if os.environ.get("GITHUB_TOKEN"):
        request.add_header("Authorization", f"Bearer {os.environ['GITHUB_TOKEN']}")
    with urllib.request.urlopen(request) as response:
        return json.load(response)


def formula(name, spec):
    release = latest(spec["repo"])
    version = release["tag_name"].removeprefix("v")
    assets = {asset["name"]: asset for asset in release["assets"]}
    blocks = {}
    for (os_name, cpu), target in TARGETS.items():
        asset = assets[f"{spec['archive']}-{target}.tar.gz"]
        digest = asset.get("digest") or ""
        if not digest.startswith("sha256:"):
            raise SystemExit(f"{spec['repo']} {release['tag_name']}: no sha256 for {asset['name']}")
        blocks.setdefault(os_name, []).append(
            f"    on_{cpu} do\n"
            f'      url "{asset["browser_download_url"]}"\n'
            f'      sha256 "{digest.removeprefix("sha256:")}"\n'
            f"    end"
        )
    platforms = "\n\n".join(f"  on_{os_name} do\n" + "\n".join(lines) + "\n  end" for os_name, lines in blocks.items())
    bins = ", ".join(f'"{b}"' for b in spec["bins"])
    return f'''# Written by update.py from the latest release of {spec["repo"]}; edit that, not this.
class {spec["class"]} < Formula
  desc "{spec["desc"]}"
  homepage "https://github.com/{spec["repo"]}"
  version "{version}"
  license {spec["license"]}

{platforms}

  def install
    bin.install {bins}
  end

  def caveats
    "{spec["caveats"]}" if OS.linux?
  end

  test do
    assert_match version.to_s, shell_output("#{{bin}}/{spec["test"]} --version")
  end
end
'''


def main():
    for name, spec in FORMULAS.items():
        path = pathlib.Path(__file__).parent / "Formula" / f"{name}.rb"
        try:
            text = formula(name, spec)
        except urllib.error.HTTPError as err:
            # No release yet: the formula, if any, stays as it is.
            print(f"{path.name}: {spec['repo']} has no release ({err.code})")
            continue
        path.write_text(text)
        print(f"{path.name}: {spec['repo']}")


if __name__ == "__main__":
    main()
