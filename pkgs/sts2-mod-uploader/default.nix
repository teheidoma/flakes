{
  lib,
  buildDotnetModule,
  unzip,
  dotnetCorePackages,
  src,
  version,
  hash,
  pkgs,
}:

buildDotnetModule {
  pname = "sts2-mod-uploader";
  inherit version src;

  postPatch = ''
    substituteInPlace ModUploader.csproj --replace-fail 'net8.0' 'net9.0'
  '';
  postFixup = ''
    mv "$out/bin/ModUploader" "$out/bin/sts2-mod-uploader"
  '';
  dotnetFlags = [ "-p:PublishSingleFile=false" ];
  dotnetRestoreFlags = [
    "--source"
    "./steam"
  ];
  executables = [ "ModUploader" ];
  nativeBuildInputs = [ unzip ];
  nugetDeps = ./deps.json;
  dotnet-sdk = dotnetCorePackages.sdk_9_0;
  dotnet-runtime = dotnetCorePackages.runtime_9_0;

}
