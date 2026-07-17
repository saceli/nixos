# Utils

## What are these for?
- `separator.sh`: generates a clean separator line and copies it directly to your clipboard using either an X11 or Wayland clipboard utility which is detected automatically.

- `gen-default-dot-nix`: regenerates the nested `default.nix` module tree. Run this after adding a new module anywhere in the tree so it can be referenced through clean attribute paths, e.g. `boot.kernel` instead of manually writing `./path/to/modules/boot/kernel`.

All of these are small vibecoded helper tools made for convenience while developing and maintaining the flake.

## License

The scripts under the folder `utils/` are licensed under The Unlicense. See the [LICENSE](LICENSE) file for details.
