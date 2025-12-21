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
    | append ($nu.home-path | path join ".bun/bin")
    | append ($nu.home-path | path join "go/bin")
    | append "/mnt/c/Windows"
    | append "/mnt/c/Windows/System32"
    | uniq
    | str join (char esep)
)
# Set OPAM environment variables in Nu
$env.DISPLAY = ":0"
$env.WAYLAND_DISPLAY = "wayland-0"
$env.GDK_BACKEND = "wayland"

$env.PATH_TO_FX = "path/to/javafx-sdk-25/lib"
$env.OPAM_LAST_ENV = "/home/amraly/.opam/.last-env/env-b5dd01d682adcb41baa5f120b9a1830d-0"
$env.OPAM_SWITCH_PREFIX = "/home/amraly/.opam/default"
$env.OCAMLTOP_INCLUDE_PATH = "/home/amraly/.opam/default/lib/toplevel"
$env.CAML_LD_LIBRARY_PATH = "/home/amraly/.opam/default/lib/stublibs:/home/amraly/.opam/default/lib/ocaml/stublibs:/home/amraly/.opam/default/lib/ocaml"
$env.OCAML_TOPLEVEL_PATH = "/home/amraly/.opam/default/lib/toplevel"
$env.MANPATH = ":/home/amraly/.opam/default/man"

# Update PATH to include OPAM bin first
$env.PATH = (
    $env.PATH
    | split row (char esep)
    | prepend "/home/amraly/.opam/default/bin"
    | uniq
    | str join (char esep)
)

# let ip = (open /etc/resolv.conf
#     | lines
#     | where $it =~ "nameserver"
#     | str replace "nameserver " ""
#     | str trim
#     | get 0)
#

