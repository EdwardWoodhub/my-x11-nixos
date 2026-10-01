{ config, pkgs, lib, ... }:

{
  imports = [
    # 1. 引入官方 LiveCD 核心与安装器模块（负责生成 ISO 引导、SquashFS、自动登录 live 环境等）
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-base.nix>

    # 2. 引入你现有的系统配置（XFCE 桌面、中文字体、常用软件等）
    ./configuration.nix
  ];

  # 3. 禁用与 LiveCD 冲突的实体机引导与硬件设置
  boot.loader.grub.enable = lib.mkForce false;
  
  # Live 镜像内一般不需要 VMware tools 服务强行检查，设为 false 避免未适配环境报错
  virtualisation.vmware.guest.enable = lib.mkForce false;

  # 4. 配置 LiveCD ISO 的镜像名称与标签
  # --- 修改这里：使用 lib.mkForce 解决名称冲突 ---
  image.baseName = lib.mkForce "my-x11-nixos-vm";
  isoImage.isoBaseName = lib.mkForce "my-x11-nixos-vm";
  isoImage.volumeID = lib.mkForce "NIXOS_X11";



  # 5. 允许免密码 sudo，方便在 Live 环境下进行运维或安装
  security.sudo.wheelNeedsPassword = false;

  # 6. 配置 Live 默认用户免密自动登录 XFCE 桌面
  services.displayManager.autoLogin = {
    enable = true;
    user = "nack";
  };
}
