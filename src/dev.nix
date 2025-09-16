{ pkgs, ... }:

{
  seal.defaults.devShell = "dev";
  integrate.devShell = {
    devShell = pkgs.mkShell {
      packages = with pkgs; [
        nil
        nixfmt-rfc-style

        just
        nushell
        fd

        nodePackages.prettier
        nodePackages.yaml-language-server
        nodePackages.vscode-langservers-extracted
        markdownlint-cli
        nodePackages.markdown-link-check
        marksman
        taplo
        nodePackages.cspell
      ];
    };
  };
}
