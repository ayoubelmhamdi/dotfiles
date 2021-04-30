# .bash_profile

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

alias i="sudo xbps-install -S"
alias c=clear





if [ -e /root/.nix-profile/etc/profile.d/nix.sh ]; then . /root/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
