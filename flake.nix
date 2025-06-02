{
  description = "A shell script for building XeLaTeX documents.";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgsFor = nixpkgs.legacyPackages;
      lxmake = pkgs: let
        deps = with pkgs; [
          graphviz
          (texliveBasic.withPackages (ps: with ps; [
            collection-latexrecommended
            collection-fontsrecommended
            collection-latexextra
            collection-plaingeneric
            collection-langcjk
            collection-binextra
            collection-bibtexextra
          ]))
        ];
      in
        pkgs.runCommand "lxmake" {
          nativeBuildInputs = with pkgs; [ makeWrapper ];
        } ''
          mkdir -p "$out/bin"
          cp ${./lxmake} "$out/bin/lxmake"
          wrapProgram "$out/bin/lxmake" \
            --prefix PATH : ${pkgs.lib.makeBinPath deps}
        '';
    in {
      packages = forAllSystems (system: {
        default = lxmake pkgsFor.${system};
      });
    };
}
