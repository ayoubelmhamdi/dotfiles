# THE AYOUB DOTFILES : by git --bare

```
git clone                                           \
    --bare                                          \
    https://github.com/ayoubelmhamdi/dotfiles.git   \
    $HOME/dotfiles 
```

```
cd $HOME/dotfiles
git remote                                      \
    set-url                                     \
    origin                                      \
    git@github.com:ayoubelmhamdi/dotfiles.git   \
    >/dev/null 2>&1
```

```
/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME  config --local status.showUntrackedFiles no
/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME  checkout --force  

```
