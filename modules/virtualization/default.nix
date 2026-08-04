{
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;

  virtualisation.libvirtd.qemu = {
    swtpm.enable = true;
  };
}
