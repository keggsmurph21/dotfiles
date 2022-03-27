# dotfiles

## installation

    $ ./bootstrap

This will essentially install [`ansible`](https://www.ansible.com/) locally and use it
to create a bunch of symlinks into your `$HOME` directory (or `$DESTDIR`, if set).

## usage

    $ dot pull  # get latest changes (sufficient for most cases)
    $ dot-sync  # re-run the `sync.yml` ansible-playbook
