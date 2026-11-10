{
  config,
  lib,
  options,
  ...
}:

let
  inherit (lib) attrByPath concatLists filter isAttrs mapAttrsToList splitString;

  # Recursively collect the dotted path of every option declared under options.cfg.
  collectOptionPaths =
    prefix: set:
    concatLists (
      mapAttrsToList (
        name: value:
        let
          path = if prefix == "" then name else "${prefix}.${name}";
        in
        if isAttrs value && value ? _type && value._type == "option" then
          # Options defaulting to null are intentionally optional and are
          # therefore never required to be set explicitly.
          if (value.default or null) == null then
            [ ]
          else
            [ path ]
        else if isAttrs value then
          collectOptionPaths path value
        else
          [ ]
      ) set
    );

  allPaths = collectOptionPaths "" options.cfg;

  # cfg.allowDefaultValues is the toggle itself; requiring it to be set
  # explicitly would defeat its purpose, so it is excluded from the check.
  checkedPaths = filter (path: path != "allowDefaultValues") allPaths;

  check =
    path:
    let
      option = attrByPath (splitString "." path) { } options;
    in
    {
      assertion = option.isDefined or false;
      message = "cfg: The option '${path}' is not set and cfg.allowDefaultValues is false. Please set '${path}' explicitly in your configuration, or set cfg.allowDefaultValues = true to fall back to the declared defaults (intended for CI only).";
    };
in
{
  options.cfg.allowDefaultValues = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = ''
      Whether cfg.* options that were not set explicitly may fall back to
      their declared default values. When false (the default), the build
      fails if any cfg.* option that has a non-null default is left unset.
      Intended to be enabled only in CI/CD pipelines; regular systems must
      set every cfg.* option explicitly.
    '';
  };

  config = lib.mkIf (!config.cfg.allowDefaultValues) {
    assertions = map check checkedPaths;
  };
}
