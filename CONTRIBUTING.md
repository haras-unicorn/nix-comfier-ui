# Contributing to Nix Comfier UI

This flake uses the [perch nix framework](https://altibiz.github.io/perch/) for
organization.

## Structure

Generated via `^eza --tree --git-ignore` and trimmed:

```text
├── CONTRIBUTING.md
├── cspell.yaml
├── flake.lock
├── flake.nix
├── justfile
├── LICENSE.md
├── README.md
└── src
    └── ... perch modules ...
```

## Tooling

The flake is direnv-friendly, so just run `direnv allow .`.

Please refer to the `src/dev.nix` file for available tooling.

## Commands

The flake uses [just](https://github.com/casey/just).

Please refer to the `justfile` file for available commands or run `just --list`.
