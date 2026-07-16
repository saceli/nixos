{
  # delete history every logout globally
  environment.etc."bash_logout".text = ''
    history -c
    history -w
    rm -f ~/.bash_history*
  '';
}