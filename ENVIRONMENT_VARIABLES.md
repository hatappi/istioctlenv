## Environment variables

You can configure how `istioctlenv` operates with the following settings:

name | default | description
-----|---------|------------
`ISTIOCTLENV_VERSION` | | Specifies the istioctl version to be used.<br>Also see `istioctlenv help shell`.
`ISTIOCTLENV_ROOT` | `~/.istioctlenv` | Defines the directory under which istioctl versions and shims reside.<br> Current value shown by `istioctlenv root`.
`ISTIOCTLENV_DEBUG` | | Outputs debug information.<br>Also as: `istioctlenv --debug <subcommand>`
`ISTIOCTLENV_HOOK_PATH` | | Colon-separated list of paths searched for istioctlenv hooks.
`ISTIOCTLENV_DIR` | `$PWD` | Directory to start searching for `.istioctl-version` files.
