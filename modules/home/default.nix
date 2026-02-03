{ config, pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./lazyvim.nix
    ./nh.nix
  ];

  home = {
    username = "colbary";
    homeDirectory = "/home/colbary";
    stateVersion = "25.05";
    packages = with pkgs; [
    ];
  };
}
