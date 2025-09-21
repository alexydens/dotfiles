{
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
  inputs.neovim-nightly-overlay.url = github:nix-community/neovim-nightly-overlay;
  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.lenovo-nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [ ./configuration.nix ];
    };
  };
}
