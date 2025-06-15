{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

     home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
     };
     xremap-flake.url = "github:xremap/nix-flake";
     ghostty = {
        url = "github:ghostty-org/ghostty";
      };
  };

  outputs = { self, nixpkgs, ghostty, ... }@inputs: {
    # use "nixos", or your hostname as the name of the configuration
    # it's a better practice than "default" shown in the video
    nixosConfigurations.katana = nixpkgs.lib.nixosSystem {
      #extraSpecialArgs = {inherit inputs;};
      specialArgs = {inherit inputs;};
      # system= "x86_64-linux";
      modules = [
        ./hosts/default/configuration.nix
        # ./modules/nixos/palenight.nix
        ./modules/nixos/deepocean.nix
        inputs.home-manager.nixosModules.default
        ({ pkgs, ... }: {
          environment.systemPackages = [
            ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default
          ];
        })
      ];};
  };
}
