{lib, buildGoModule, src, version, hash}:

buildGoModule {
            pname = "signoz-mcp-server";
            inherit version src;

            vendorHash = hash; 

            subPackages = [ "cmd/server" ];
            ldflags = [
              "-s"
              "-w"
              "-X github.com/SigNoz/signoz-mcp-server/pkg/version.Version=v${version}"
            ];

            postInstall = ''
              mv "$out/bin/server" "$out/bin/signoz-mcp-server"
            '';

            meta = {
              description = "MCP server for SigNoz";
              homepage = "https://github.com/SigNoz/signoz-mcp-server";
              license = lib.licenses.asl20;
              mainProgram = "signoz-mcp-server";
              platforms = lib.platforms.linux;
            };
}
