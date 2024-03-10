{ inputs, outputs, lib, config, pkgs, ... }:
{
  ## ACPI EVENTS
  services.acpid = {
  enable = true;
  handlers = {
  	brightnessUpEvent = {
		event = "video/brightnessup";
		action = ''
      /home/amon/clones/bright/bright.sh "up"
      '';
		};
	brightnessDownEvent = {
		event = "video/brightnessdown";
		action = ''
      /home/amon/clones/bright/bright.sh "down"
      '';
      };
  	};
  };
}
