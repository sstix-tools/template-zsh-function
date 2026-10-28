{
  description = "template-zsh-function - Template for autoloadable Zsh functions";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (system: pkgs: rec {
        default = template-zsh-function;
        template-zsh-function = pkgs.stdenvNoCC.mkDerivation {
          pname = "template-zsh-function";
          version = "1.0.0";
          src = ./.;

          dontBuild = true;

          installPhase = ''
            mkdir -p $out/share/zsh/functions $out/share/zsh/site-functions
            if [ -d functions ]; then
              cp -r functions/* $out/share/zsh/functions/ 2>/dev/null || true
              cp -r functions/* $out/share/zsh/site-functions/ 2>/dev/null || true
            fi
            if [ -d completion ]; then
              cp -r completion/* $out/share/zsh/site-functions/ 2>/dev/null || true
            fi
          '';

          meta = {
            description = "Autoloadable Zsh function extension";
            platforms = pkgs.lib.platforms.unix;
          };
        };
      });
    };
}
