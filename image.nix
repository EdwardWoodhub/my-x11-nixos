{ pkgs ? import <nixpkgs> {}
, configFile ? ./configuration.nix
}:

let
  # 经典模式直接求值 NixOS 系统
  nixos = import <nixpkgs/nixos> {
    configuration = configFile;
    system = "x86_64-linux"; # 如果是 ARM 机器则写 "aarch64-linux"
  };

  toplevel = nixos.system;
in
pkgs.dockerTools.buildLayeredImage {
  name = "my-x11-nixos-vm";
  tag = "latest";

  # 最多切分 100 层，最大化复用基础库和未变动组件
  maxLayers = 100;

  # 将顶层闭包放入容器内部
  contents = [ toplevel ];

  config = {
    Env = [ "TARGET_TOPLEVEL=${toplevel}" ];
    Cmd = [ "${pkgs.coreutils}/bin/echo" "${toplevel}" ];
  };
}
