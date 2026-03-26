{...}: {
  flake.nixosModules.sound = {...}: {
    # Enable bluetooth and bluetooth services
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;

    # Enable sound with pipewire.
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      systemWide = false;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # Enable JACK via Pipewire.
      jack.enable = true;
    };
  };
}
