{ pkgs, ... }:

{
  xdg.mimeApps = {
    enable = true;
      # Writer
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "libreoffice-writer.desktop";
      "application/vnd.oasis.opendocument.text" = "libreoffice-writer.desktop";
      "application/msword" = "libreoffice-writer.desktop";

      # Calc
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "libreoffice-calc.desktop";
      "application/vnd.oasis.opendocument.spreadsheet" = "libreoffice-calc.desktop";
      "application/vnd.ms-excel" = "libreoffice-calc.desktop";

      # Impress
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" = "libreoffice-impress.desktop";
      "application/vnd.oasis.opendocument.presentation" = "libreoffice-impress.desktop";
      "application/vnd.ms-powerpoint" = "libreoffice-impress.desktop";

    };

  };
}