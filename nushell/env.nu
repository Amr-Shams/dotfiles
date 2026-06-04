# env.nu
#
# Installed by:
# version = "0.108.0"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.
$env.GOSUMDB = "sum.golang.org"
$env.GOPROXY = "https://proxy.golang.org,direct"
$env.BUN_INSTALL = "~/.bun"
$env.PATH = (
    $env.PATH
    | split row (char esep)
    | append "/usr/local/bin"
    | append "/usr/local/sbin"
    | append "/usr/sbin"
    | append "/usr/bin"
    | append "/sbin"
    | append "/bin"
    | append ($nu.home-dir | path join ".bun/bin")
    | append ($nu.home-dir | path join "go/bin")
    | append ($nu.home-dir | path join ".npm-global/bin")
    | append "/mnt/c/Windows"
    | append "/mnt/c/Windows/System32"
    | append ($nu.home-dir | path join ".cargo/bin")
    | append ($nu.home-dir | path join ".local/bin")
    | append ($nu.home-dir | path join ".nvm")
    | append ($nu.home-dir | path join ".opencode/bin")
    | uniq
    | str join (char esep)
    )
    # Set OPAM environment variables in Nu
    $env.DISPLAY = ":0"
    $env.WAYLAND_DISPLAY = "wayland-0"
    $env.GDK_BACKEND = "wayland"

    $env.JAVA_HOME = "/usr/lib/jvm/java-21-openjdk"
    $env.OPAM_LAST_ENV = ($nu.home-dir | path join ".opam/.last-env/env-b5dd01d682adcb41baa5f120b9a1830d-0")
    $env.OPAM_SWITCH_PREFIX = ($nu.home-dir | path join ".opam/default")
    $env.OCAMLTOP_INCLUDE_PATH = ($nu.home-dir | path join ".opam/default/lib/toplevel")
    $env.CAML_LD_LIBRARY_PATH = (($nu.home-dir | path join ".opam/default/lib/stublibs") + ":" + ($nu.home-dir | path join ".opam/default/lib/ocaml/stublibs") + ":" + ($nu.home-dir | path join ".opam/default/lib/ocaml"))
    $env.OCAML_TOPLEVEL_PATH = ($nu.home-dir | path join ".opam/default/lib/toplevel")
    $env.MANPATH = (":" + ($nu.home-dir | path join ".opam/default/man"))

    # Update PATH to include OPAM bin first
    $env.PATH = (
    $env.PATH
    | split row (char esep)
    | prepend ($nu.home-dir | path join ".opam/default/bin")
    | uniq
    | str join (char esep)
)
  $env.SUDO_EDITOR = "nvim"
  $env.EDITOR = "nvim"
  $env.VISUAL = "nvim"

# let ip = (open /etc/resolv.conf
#     | lines
#     | where $it =~ "nameserver"
#     | str replace "nameserver " ""
#     | str trim
#     | get 0)
#

