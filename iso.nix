{ pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-graphical-plasma6.nix>
    # 如果想用 GNOME，可改为:
    # <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix>
  ];

  # 可在此处添加自定义软件包或配置
  # environment.systemPackages = with pkgs; [ vim git ];
}
