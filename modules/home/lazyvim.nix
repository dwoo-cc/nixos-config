{ pkgs, inputs, ... }:{
  imports = [ inputs.lazyvim.homeManagerModules.default ];
  programs.lazyvim = {
    enable = true;
    extras = {
      lang.nix.enable = true;
      lang.lua.enable = true;
    };
    treesitterParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [ 
      lua 
      nix 
    ];
    extraPackages = with pkgs; [
      # LSP servers
      nixd
      statix
      # Formatters
      black
      alejandra
      # Tools
      ripgrep
      fd
    ];
  };
}
