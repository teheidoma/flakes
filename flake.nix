{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    signoz-src = {
      url = "github:SigNoz/signoz-mcp-server/v0.19.0";
      flake = false;
    };
    sts2-mod-uploader-src = {
      url = "github:megacrit/sts2-mod-uploader/v0.2.0";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      signoz-src,
      sts2-mod-uploader-src,
      ...
    }:
    let
      systems = [
        "x86_64-linux"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          signoz-mcp-server = pkgs.callPackage ./pkgs/signoz {
            src = signoz-src;
            hash = "sha256-EH8vRSGSyNLyXQWJ4SVDVCURm53rhABPPSfL4SxfL5A=";
            version = "v0.19.0";
          };
          sts2-mod-uploader = pkgs.callPackage ./pkgs/sts2-mod-uploader {
            src = sts2-mod-uploader-src;
            hash = pkgs.lib.fakeHash;
            version = "0.2.0";
          };

        }
      );

      apps = forAllSystems (system: {
        signoz-mcp-server = {
          type = "app";
          program = "${self.packages.${system}.signoz-mcp-server}/bin/signoz-mcp-server";
        };
        sts2-mod-uploader = {
          type = "app";
          program = "${self.packages.${system}.sts2-mod-uploader}/bin/ModUploader";
        };
      });
    };
}
