{ pkgs, ... }:
{

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  time.timeZone = "Asia/Shanghai";

  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    tree
  ];

  programs.fish.enable = true;
}
