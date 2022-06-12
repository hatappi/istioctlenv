# How It Works

At a high level, istioctlenv intercepts istioctl commands using shim
executables injected into your `PATH`, determines which istioctl version
has been specified by your application, and passes your commands along
to the correct istioctl installation.

## Understanding PATH

When you run all the variety of istioctl commands using  `istioctl`, your operating system
searches through a list of directories to find an executable file with
that name. This list of directories lives in an environment variable
called `PATH`, with each directory in the list separated by a colon:

    /usr/local/bin:/usr/bin:/bin

Directories in `PATH` are searched from left to right, so a matching
executable in a directory at the beginning of the list takes
precedence over another one at the end. In this example, the
`/usr/local/bin` directory will be searched first, then `/usr/bin`,
then `/bin`.

## Understanding Shims

istioctlenv works by inserting a directory of _shims_ at the front of your
`PATH`:

    ~/.istioctlenv/shims:/usr/local/bin:/usr/bin:/bin

Through a process called _rehashing_, istioctlenv maintains shims in that
directory to match every `istioctl` command across every installed version
of istioctl.

Shims are lightweight executables that simply pass your command along
to istioctlenv. So with istioctlenv installed, when you run `istioctl` your
operating system will do the following:

* Search your `PATH` for an executable file named `istioctl`
* Find the istioctlenv shim named `istioctl` at the beginning of your `PATH`
* Run the shim named `istioctl`, which in turn passes the command along to
  istioctlenv

## Choosing the istioctl Version

When you execute a shim, istioctlenv determines which istioctl version to use by
reading it from the following sources, in this order:

1. The `ISTIOCTLENV_VERSION` environment variable (if specified). You can use
   the [`istioctlenv shell`](https://github.com/hatappi/istioctlenv/blob/master/COMMANDS.md#istioctlenv-shell) command to set this environment
   variable in your current shell session.

2. The specific `.istioctl-version` file in the current
   directory (if present). You can modify the current directory's
   `.istioctl-version` file with the [`istioctlenv local`](https://github.com/hatappi/istioctlenv/blob/master/COMMANDS.md#istioctlenv-local)
   command.

3. The first `.istioctl-version` file found (if any) by searching each parent
   directory, until reaching the root of your filesystem.

4. The global `~/.istioctlenv/version` file. You can modify this file using
   the [`istioctlenv global`](https://github.com/hatappi/istioctlenv/blob/master/COMMANDS.md#istioctlenv-global) command. If the global version
   file is not present, istioctlenv assumes you want to use the "system" istioctl.
   (In other words, whatever version would run if istioctlenv isn't present in `PATH`.)

**NOTE:** You can activate multiple versions at the same time, including multiple
versions of istioctl simultaneously or per project.

## Locating the istioctl Installation

Once istioctlenv has determined which version of istioctl,
it passes the command along to the corresponding istioctl installation.

Each istioctl version is installed into its own directory under
`~/.istioctlenv/versions`.

For example, you might have these versions installed:

* `~/.istioctlenv/versions/1.13.0/`
* `~/.istioctlenv/versions/1.14.0/`

As far as istioctlenv is concerned, version names are simply the directories in
`~/.istioctlenv/versions`.

