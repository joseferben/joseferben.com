with import <nixpkgs> { };

mkShell {
  buildInputs = [ hugo ];
  shellHook = "hugo server";
}
