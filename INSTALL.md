# Installation

## Basic GitHub Checkout

This will get you going with the latest version of istioctlenv and make it
easy to fork and contribute any changes back upstream.

1. **Check out istioctlenv where you want it installed.**
   A good place to choose is `$HOME/.istioctlenv` (but you can install it somewhere else).

        $ git clone https://github.com/hatappi/istioctlenv.git ~/.istioctlenv

2. **Define environment variable `ISTIOCTLENV_ROOT`** to point to the path where
   istioctlenv repo is cloned and add `$ISTIOCTLENV_ROOT/bin` to your `$PATH` for access
   to the `istioctlenv` command-line utility.

        $ echo 'export ISTIOCTLENV_ROOT="$HOME/.istioctlenv"' >> ~/.bash_profile
        $ echo 'export PATH="$ISTIOCTLENV_ROOT/bin:$PATH"' >> ~/.bash_profile

    **Zsh note**: Modify your `~/.zshenv` file instead of `~/.bash_profile`.

    **Ubuntu note**: Modify your `~/.bashrc` file instead of `~/.bash_profile`.

3. **Add `istioctlenv init` to your shell** to enable shims, and auto-completion.
   Please make sure `eval "$(istioctlenv init -)"` is placed toward the end of the shell
   configuration file since it manipulates `PATH` during the initialization.

        $ echo 'eval "$(istioctlenv init -)"' >> ~/.bash_profile

    **Zsh note**: Modify your `~/.zshenv` or `~/.zshrc` file instead of `~/.bash_profile`.
    
    **Ubuntu note**: Modify your `~/.bashrc` file instead of `~/.bash_profile`.
    
    **General warning**: There are some systems where the `BASH_ENV` variable is configured
    to point to `.bashrc`. On such systems you should almost certainly put the abovementioned line
    `eval "$(istioctlenv init -)` into `.bash_profile`, and **not** into `.bashrc`. Otherwise you
    may observe strange behaviour, such as `istioctlenv` getting into an infinite loop.
    See pyenv's issue [#264](https://github.com/yyuu/pyenv/issues/264) for details.

4. **Restart your shell so the path changes take effect.**
   You can now begin using istioctlenv.

        $ exec $SHELL

5. **Install istioctl versions into `$ISTIOCTLENV_ROOT/versions`.**
   For example, to download and install istioctl 1.14.0, run:

        $ istioctlenv install 1.14.0

An example `.zshrc` that is properly configured may look like

```shell
export ISTIOCTLENV_ROOT="$HOME/.istioctlenv"
export PATH="$ISTIOCTLENV_ROOT/bin:$PATH"
eval "$(istioctlenv init -)"
```

## via ZPlug plugin manager for Zsh

Add the following line to your `.zshrc`:

```zplug "RiverGlide/zsh-istioctlenv", from:gitlab```

Then install the plugin
~~~ zsh
  $ source ~/.zshrc
  $ zplug install
~~~
The ZPlug plugin will install and initialise `istioctlenv` and add `istioctlenv` and `istioctlenv-install` to your `PATH`

## Upgrading

If you've installed istioctlenv using the instructions above, you can
upgrade your installation at any time using git.

To upgrade to the latest development version of istioctlenv, use `git pull`:

    $ cd ~/.istioctlenv
    $ git pull

To upgrade to a specific release of istioctlenv, check out the corresponding tag:

    $ cd ~/.istioctlenv
    $ git fetch
    $ git tag
    v20160417
    $ git checkout v20160417

## Uninstalling istioctlenv

The simplicity of istioctlenv makes it easy to temporarily disable it, or
uninstall from the system.

1. To **disable** istioctlenv managing your istioctl versions, simply remove the
  `istioctlenv init` line from your shell startup configuration. This will
  remove istioctlenv shims directory from PATH, and future invocations like
  `istioctlenv` will execute the system istioctl version, as before istioctlenv.

  `istioctlenv` will still be accessible on the command line, but environment 
  won't be affected by version switching.

2. To completely **uninstall** istioctlenv, perform step (1) and then remove
   its root directory. This will **delete all istioctl versions** that were
   installed under `` `istioctlenv root`/versions/ `` directory:

        rm -rf `istioctlenv root`

## Uninstalling istioctl Versions

As time goes on, you will accumulate istioctl versions in your
`~/.istioctlenv/versions` directory.

To remove old istioctl versions, `istioctlenv uninstall` command to automate
the removal process.

Alternatively, simply `rm -rf` the directory of the version you want
to remove. You can find the directory of a particular istioctl version
with the `istioctlenv prefix` command, e.g. `istioctlenv prefix 1.13.0`.
