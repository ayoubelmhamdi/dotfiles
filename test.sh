#!/bin/bash

bwrap \
  --ro-bind / / \
  --proc /proc \
  --dev /dev \
  --tmpfs /tmp \
  --dir /home/mhamdi/tmp-local/link-dotfiles \
  --bind /home/mhamdi/tmp-local/link-dotfiles /home/mhamdi/tmp-local/link-dotfiles \
  --dir /tmp/home \
  --dir /tmp/home/.config \
  --dir /home/mhamdi/.local/share/ \
  --setenv HOME /tmp/home \
  --unshare-net \
  --unshare-pid \
  /bin/bash

