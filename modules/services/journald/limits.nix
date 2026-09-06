{
  # prevent journald log from
  # getting absurdly large
  services.journald.settings.Journal = {
    SystemMaxUse = "2G";
    RuntimeMaxUse = "2G";
  };
}
