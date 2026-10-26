# lydakis/tap

Homebrew formulas for [sandfs](https://github.com/lydakis/sandfs) and [Graft](https://github.com/lydakis/graft), installed from each project's prebuilt release downloads (macOS on Apple silicon and Intel, Linux on x86_64 and aarch64).

```bash
brew install lydakis/tap/graft     # gft and graft; sandfs is built in
brew install lydakis/tap/sandfs    # the sandfs command
```

`brew upgrade` picks up new releases: a workflow here runs `update.py` every hour, which points each formula at its project's latest release, with the checksums GitHub lists for its downloads. To add a project, give it release archives named `NAME-TARGET.tar.gz` and add it to `FORMULAS` in `update.py`.

On Linux, mounts need FUSE 3 (the `fuse3` package).
