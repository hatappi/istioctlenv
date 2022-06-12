# Advanced Configuration

For hobbyists this might be interesting.

`istioctlenv init` is the only command that crosses the line of loading
extra commands into your shell. Coming from rvm, some of you might be
opposed to this idea. Here's what `istioctlenv init` actually does:

1. **Sets up your shims path.** This is the only requirement for istioctlenv to
   function properly. You can do this by hand by prepending
   `~/.istioctlenv/shims` to your `$PATH`.

2. **Installs autocompletion.** This is entirely optional but pretty
   useful. Sourcing `~/.istioctlenv/completions/istioctlenv.bash` will set that
   up. There is also a `~/.istioctlenv/completions/istioctlenv.zsh` for Zsh
   users.

3. **Rehashes shims.** From time to time you'll need to rebuild your
   shim files. Doing this on init makes sure everything is up to
   date. You can always run `istioctlenv rehash` manually.

4. **Installs the sh dispatcher.** This bit is also optional, but allows
   istioctlenv and plugins to change variables in your current shell, making
   commands like `istioctlenv shell` possible. The sh dispatcher doesn't do
   anything crazy like override `cd` or hack your shell prompt, but if
   for some reason you need `istioctlenv` to be a real script rather than a
   shell function, you can safely skip it.

To see exactly what happens under the hood for yourself, run `istioctlenv init -`.
