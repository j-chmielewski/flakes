{
  description = "Opinionated nix flakes for development";

  outputs = { self }: {
    templates = {
      python = {
        path = ./python;
        description = "Python with Poetry";
      };
    };
  };
}
