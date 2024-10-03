{
  description = "Opinionated nix flakes for development";

  outputs = { self }: {
    templates = {
      python-pipenv = {
        path = ./python-pipenv;
        description = "Python with Pipenv";
      };
      rust = {
        path = ./rust;
        description = "Rust";
      };
    };
  };
}
