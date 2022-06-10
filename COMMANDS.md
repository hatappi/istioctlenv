# Command Reference

Like `git`, the `istioctlenv` command delegates to subcommands based on its
first argument. 

All subcommands are:

* [`istioctlenv commands`](#istioctlenv-commands)
* [`istioctlenv completions`](#istioctlenv-completions)
* [`istioctlenv exec`](#istioctlenv-exec)
* [`istioctlenv global`](#istioctlenv-global)
* [`istioctlenv help`](#istioctlenv-help)
* [`istioctlenv hooks`](#istioctlenv-hooks)
* [`istioctlenv init`](#istioctlenv-init)
* [`istioctlenv install`](#istioctlenv-install)
* [`istioctlenv local`](#istioctlenv-local)
* [`istioctlenv prefix`](#istioctlenv-prefix)
* [`istioctlenv rehash`](#istioctlenv-rehash)
* [`istioctlenv root`](#istioctlenv-root)
* [`istioctlenv shell`](#istioctlenv-shell)
* [`istioctlenv shims`](#istioctlenv-shims)
* [`istioctlenv uninstall`](#istioctlenv-uninstall)
* [`istioctlenv version`](#istioctlenv-version)
* [`istioctlenv --version`](#istioctlenv---version)
* [`istioctlenv version-file`](#istioctlenv-version-file)
* [`istioctlenv version-file-read`](#istioctlenv-version-file-read)
* [`istioctlenv version-file-write`](#istioctlenv-version-file-write)
* [`istioctlenv version-name`](#istioctlenv-version-name)
* [`istioctlenv version-origin`](#istioctlenv-version-origin)
* [`istioctlenv versions`](#istioctlenv-versions)
* [`istioctlenv whence`](#istioctlenv-whence)
* [`istioctlenv which`](#istioctlenv-which)

## `istioctlenv commands`

Lists all available istioctlenv commands.

## `istioctlenv completions`

Provides auto-completion for itself and other commands by calling them with `--complete`.

## `istioctlenv exec`

Run an executable with the selected istioctl version.

Assuming there's an already installed istioctl by e.g `istioctlenv install 1.14.0` and 
  selected by e.g `istioctlenv global 1.14.0`,

```shell
➜ istioctlenv exec istioctl proxy-status
```

## `istioctlenv global`

Sets the global version of istioctl to be used in all shells by writing
the version name to the `~/.istioctlenv/version` file. This version can be
overridden by an application-specific `.istioctl-version` file, or by
setting the `ISTIOCTLENV_VERSION` environment variable.

```shell
➜ istioctlenv global 1.14.0

# Showcase
➜ istioctlenv versions
  system
  1.13.0
* 1.14.0 (set by /Users/hatappi/.istioctlenv/version)

➜ istioctlenv version
1.14.0 (set by /Users/hatappi/.istioctlenv/version)

➜ istioctl version -s | head -n 1
client version: 1.14.0
```

The special version name `system` tells istioctlenv to use the system istioctl
(detected by searching your `$PATH`).

When run without a version number, `istioctlenv global` reports the
currently configured global version.

## `istioctlenv help`

Parses and displays help contents from a command's source file.

A command is considered documented if it starts with a comment block
that has a `Summary:` or `Usage:` section. Usage instructions can
span multiple lines as long as subsequent lines are indented.
The remainder of the comment block is displayed as extended
documentation.


```shell
➜ istioctlenv help help
```

```shell
➜ istioctlenv help install
```

## `istioctlenv hooks`

List hook scripts for a given istioctlenv command

```shell
➜ istioctlenv hooks uninstall
```

## `istioctlenv init`

Configure the shell environment for istioctlenv. Must have if you want to integrate `istioctlenv` with your shell.

The following displays how to integrate `istioctlenv` with your user's shell:

```shell
➜ istioctlenv init
```

Usually it boils down to adding to your `.bashrc` or `.zshrc` the following:

```
eval "$(istioctlenv init -)"
```

## `istioctlenv install`

Install a istioctl version (using `istioctl-build`). It's required that the version is a known installable definition by `istioctl-build`.

```shell
➜ istioctlenv install 1.14.0

```

## `istioctlenv local`

Sets a local istioctl version by writing the version
name to a `.istioctl-version` file in the current directory. This version
overrides the global version, and can be overridden itself by setting
the `ISTIOCTLENV_VERSION` environment variable or with the `istioctlenv shell`
command.

```shell
> istioctlenv local 1.14.0
```

When run without a version number, `istioctlenv local` reports the currently
configured local version. You can also unset the local version:


```shell
> istioctlenv local --unset
```

Previous versions of istioctlenv stored local version specifications in a
file named `.istioctlenv-version`. For backwards compatibility, istioctlenv will
read a local version specified in an `.istioctlenv-version` file, but a
`.istioctl-version` file in the same directory will take precedence.

## `istioctlenv prefix`

Displays the directory where an istioctl version is installed. If no
version is given, `istioctlenv prefix' displays the location of the
currently selected version.

```shell
➜ istioctlenv prefix
/Users/hatappi/.istioctlenv/versions/1.14.0
```

## `istioctlenv rehash`

Installs shims for all istioctl binaries known to istioctlenv.
Run this command after you install a new
version of istioctl, or install a package that provides binaries.

```shell
➜ istioctlenv rehash
```

## `istioctlenv root`

Display the root directory where versions and shims are kept

```shell
➜ istioctlenv root
/Users/hatappi/.istioctlenv
```

## `istioctlenv shell`

Sets a shell-specific istioctl version by setting the `ISTIOCTLENV_VERSION`
environment variable in your shell. This version overrides
specific versions and the global version.

```shell
➜ istioctlenv shell 1.5.4
```

When run without a version number, `istioctlenv shell` reports the current
value of `ISTIOCTLENV_VERSION`. You can also unset the shell version:

```shell
➜ istioctlenv shell --unset
```

Note that you'll need istioctlenv's shell integration enabled (refer to [Installation](./INSTALL.md]) in order to use this command. If you
prefer not to use shell integration, you may simply set the
`ISTIOCTLENV_VERSION` variable yourself:

```shell
> export ISTIOCTLENV_VERSION=1.14.0
```

## `istioctlenv shims`

List existing istioctlenv shims

```shell
➜ istioctlenv shims
/Users/hatappi/.istioctlenv/shims/istioctl
```

## `istioctlenv uninstall`

Uninstalls the specified version if it exists, otherwise - error.

```shell
➜ istioctlenv uninstall 1.14.0
```

## `istioctlenv version`

Displays the currently active istioctl version, along with information on
how it was set.

```shell
➜ istioctlenv version
1.14.0 (set by /Users/hatappi/.istioctlenv/version)
```

## `istioctlenv --version`

Show version of `istioctlenv` in format of `istioctlenv <version>`.

## `istioctlenv version-file`

Detect the file that sets the current istioctlenv version


```shell
➜ istioctlenv version-file
/tmp/.istioctl-version
```

## `istioctlenv version-file-read`

Reads specified version file if it exists

```shell
➜ istioctlenv version-file-read .istioctl-version
1.13.0
```

## `istioctlenv version-file-write`

Writes specified version(s) to the specified file if the version(s) exist

```shell
➜ istioctlenv version-file-write .istioctl-version 1.14.0
```

## `istioctlenv version-name`

Shows the current istioctl version

```shell
➜ istioctlenv version-name
1.14.0
```

## `istioctlenv version-origin`

Explain how the current istioctl version is set.

```shell
➜ istioctlenv version-origin
/tmp/.istioctl-version
```

## `istioctlenv versions`

Lists all istioctl versions known to istioctlenv, and shows an asterisk next to
the currently active version.

```shell
➜ istioctlenv versions
  system
  1.13.0
* 1.14.0 (set by /tmp/.istioctl-version)
```

## `istioctlenv whence`

Lists all istioctl versions with the given command installed.

```shell
➜ istioctlenv whence istioctl
1.13.0
1.14.0
```

## `istioctlenv which`

Displays the full path to the executable that istioctlenv will invoke when
you run the given command.

```shell
➜ istioctlenv which istioctl
/Users/hatappi/.istioctlenv/versions/1.14.0/bin/istioctl
```
