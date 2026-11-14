# flakes

A Nix flake that packages a small set of command-line tools for Linux on
`x86_64`:

- **SigNoz MCP Server** (`signoz-mcp-server`)
- **Slay the Spire 2 Mod Uploader** (`sts2-mod-uploader`)

The package sources and versions are pinned in `flake.lock`.

## Requirements

- Nix with flake support enabled
- Linux on `x86_64`

## Run a tool

Run either application directly from this flake:

```sh
nix run github:teheidoma/flakes#signoz-mcp-server
nix run github:teheidoma/flakes#sts2-mod-uploader
```

To run a local checkout, use `.` instead of `github:teheidoma/flakes`:

```sh
nix run .#signoz-mcp-server
nix run .#sts2-mod-uploader
```

You can also build a package without running it:

```sh
nix build .#signoz-mcp-server
nix build .#sts2-mod-uploader
```

## Update dependencies

Update the pinned flake inputs with:

```sh
nix flake update
```

The package definitions are in `pkgs/`. The source code for each tool is
maintained in its upstream repository; see `flake.nix` for the pinned source
references.

## License

The flake files in this repository are licensed under the MIT License; see
[`LICENSE`](LICENSE). That license does not change the terms for upstream
software fetched and packaged by this flake:

| Package | Pinned upstream | Upstream license |
| --- | --- | --- |
| SigNoz MCP Server | [v0.19.0](https://github.com/SigNoz/signoz-mcp-server/tree/v0.19.0) | Apache-2.0 |
| Slay the Spire 2 Mod Uploader | [v0.2.0](https://github.com/megacrit/sts2-mod-uploader/tree/v0.2.0) | No license file found in the upstream repository |

Check the upstream terms before redistributing either package. In particular,
the uploader's upstream repository does not state a license, so this flake
does not assign one to it. Dependencies retain their own licenses as well.
