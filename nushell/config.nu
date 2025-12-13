# config.nu
#
# Installed by: version = "0.108.0"
# Optimized for Solarized Dark terminal theme

module completions {
  def "nu-complete git branches" [] {
    ^git branch | lines | each { |line| $line | str replace '[\*\+] ' '' | str trim }
  }

  def "nu-complete git remotes" [] {
    ^git remote | lines | each { |line| $line | str trim }
  }

  export extern "git checkout" [
    branch?: string@"nu-complete git branches"
    -b: string
    -B: string
    -l
    --guess
    --overlay
    --quiet(-q)
    --recurse-submodules: string
    --progress
    --merge(-m)
    --conflict: string
    --detach(-d)
    --track(-t)
    --force(-f)
    --orphan: string
    --overwrite-ignore
    --ignore-other-worktrees
    --ours(-2)
    --theirs(-3)
    --patch(-p)
    --ignore-skip-worktree-bits
    --pathspec-from-file: string
  ]

  export extern "git push" [
    remote?: string@"nu-complete git remotes",
    refspec?: string@"nu-complete git branches"
    --verbose(-v)
    --quiet(-q)
    --repo: string
    --all
    --mirror
    --delete(-d)
    --tags
    --dry-run(-n)
    --porcelain
    --force(-f)
    --force-with-lease: string
    --recurse-submodules: string
    --thin
    --receive-pack: string
    --exec: string
    --set-upstream(-u)
    --progress
    --prune
    --no-verify
    --follow-tags
    --signed: string
    --atomic
    --push-option(-o): string
    --ipv4(-4)
    --ipv6(-6)
  ]
}

# Solarized Dark optimized theme
let solarized_dark = {
    # color for nushell primitives
    separator: cyan
    leading_trailing_space_bg: { attr: n }
    header: blue_bold
    empty: blue
    bool: cyan
    int: cyan
    filesize: yellow
    duration: yellow
    date: purple
    range: yellow_bold
    float: cyan
    string: green
    nothing: red
    binary: purple
    cellpath: cyan
    row_index: blue_bold
    record: white
    list: white
    block: cyan_bold
    hints: "#586E75"  # brightGreen from your scheme - much more visible

    # shapes for syntax highlighting
    shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
    shape_binary: purple_bold
    shape_bool: cyan
    shape_int: purple
    shape_float: purple
    shape_range: yellow_bold
    shape_internalcall: cyan_bold
    shape_external: blue
    shape_externalarg: green
    shape_literal: blue
    shape_operator: yellow
    shape_signature: blue_bold
    shape_string: green
    shape_string_interpolation: cyan_bold
    shape_datetime: purple
    shape_list: cyan_bold
    shape_table: blue_bold
    shape_record: cyan_bold
    shape_block: blue_bold
    shape_filepath: cyan
    shape_globpattern: yellow_bold
    shape_variable: purple
    shape_flag: blue_bold
    shape_custom: yellow
    shape_nothing: red
}

$env.config = {
  color_config: $solarized_dark
  edit_mode: vi
  float_precision: 2
  footer_mode: auto
  use_ansi_coloring: true
  
  # Custom cursor shapes for different vi modes
  cursor_shape: {
    vi_insert: line      # Thin line in insert mode
    vi_normal: block     # Block in normal mode
    emacs: line          # Line for emacs mode
  }

  menus: [
      {
        name: completion_menu
        only_buffer_difference: false
        marker: "| "
        type: {
            layout: columnar
            columns: 4
            col_width: 20
            col_padding: 2
        }
        style: {
            text: cyan          # Changed from green - better contrast
            selected_text: { fg: "#002B36" bg: cyan }  # Inverted colors
            description_text: yellow
        }
      }
      {
        name: history_menu
        only_buffer_difference: true
        marker: "? "
        type: {
            layout: list
            page_size: 10
        }
        style: {
            text: blue          # Changed for better visibility
            selected_text: { fg: "#002B36" bg: blue }
            description_text: yellow
        }
      }
      {
        name: help_menu
        only_buffer_difference: true
        marker: "? "
        type: {
            layout: description
            columns: 4
            col_width: 20
            col_padding: 2
            selection_rows: 4
            description_rows: 10
        }
        style: {
            text: cyan
            selected_text: { fg: "#002B36" bg: cyan }
            description_text: yellow
        }
      }
      {
        name: commands_menu
        only_buffer_difference: false
        marker: "# "
        type: {
            layout: columnar
            columns: 4
            col_width: 20
            col_padding: 2
        }
        style: {
            text: blue
            selected_text: { fg: "#002B36" bg: blue }
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.commands
            | where command =~ $buffer
            | each { |it| {value: $it.command description: $it.usage} }
        }
      }
      {
        name: vars_menu
        only_buffer_difference: true
        marker: "# "
        type: {
            layout: list
            page_size: 10
        }
        style: {
            text: purple
            selected_text: { fg: "#002B36" bg: purple }
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.vars
            | where name =~ $buffer
            | sort-by name
            | each { |it| {value: $it.name description: $it.type} }
        }
      }
      {
        name: commands_with_description
        only_buffer_difference: true
        marker: "# "
        type: {
            layout: description
            columns: 4
            col_width: 20
            col_padding: 2
            selection_rows: 4
            description_rows: 10
        }
        style: {
            text: cyan
            selected_text: { fg: "#002B36" bg: cyan }
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.commands
            | where command =~ $buffer
            | each { |it| {value: $it.command description: $it.usage} }
        }
      }
  ]
  
  keybindings: [
    {
      name: completion_menu
      modifier: none
      keycode: tab
      mode: emacs
      event: {
        until: [
          { send: menu name: completion_menu }
          { send: menunext }
        ]
      }
    }
    {
      name: completion_previous
      modifier: shift
      keycode: backtab
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menuprevious }
    }
    {
      name: history_menu
      modifier: control
      keycode: char_x
      mode: emacs
      event: {
        until: [
          { send: menu name: history_menu }
          { send: menupagenext }
        ]
      }
    }
    {
      name: history_previous
      modifier: control
      keycode: char_z
      mode: emacs
      event: {
        until: [
          { send: menupageprevious }
          { edit: undo }
        ]
      }
    }
    {
      name: commands_menu
      modifier: control
      keycode: char_t
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: commands_menu }
    }
    {
      name: vars_menu
      modifier: control
      keycode: char_y
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: vars_menu }
    }
    {
      name: commands_with_description
      modifier: control
      keycode: char_u
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: commands_with_description }
    }
  ]
}

# Custom prompt configuration
$env.PROMPT_COMMAND = {||
    let path_segment = (
        if ($env.PWD == $nu.home-path) {
            "~"
        } else {
            ($env.PWD | path basename)
        }
    )
    
    # Git branch indicator if in a git repo (suppress errors)
    let git_branch = (
        do -i { 
            ^git branch --show-current 
            | complete 
            | if $in.exit_code == 0 { 
                let branch = ($in.stdout | str trim)
                if ($branch | is-empty) { "" } else { $" (ansi purple_bold)($branch)(ansi reset)" }
            } else { 
                "" 
            }
        }
    )
    
    $"(ansi blue_bold)╭─(ansi cyan)[(ansi green)($path_segment)(ansi cyan)]($git_branch)\n(ansi blue_bold)╰─(ansi reset)"
}

# Right prompt - shows time and last command duration
$env.PROMPT_COMMAND_RIGHT = {||
    let last_exit = $env.LAST_EXIT_CODE
    let exit_indicator = if $last_exit == 0 {
        $"(ansi green)✓(ansi reset)"
    } else {
        $"(ansi red)✗(ansi reset) ($last_exit)"
    }
    
    let time = (date now | format date "%H:%M:%S")
    $"($exit_indicator) (ansi yellow)($time)(ansi reset)"
}

# Vi mode indicator in prompt
$env.PROMPT_INDICATOR_VI_INSERT = $"(ansi cyan)❯(ansi reset) "
$env.PROMPT_INDICATOR_VI_NORMAL = $"(ansi blue)❮(ansi reset) "
$env.PROMPT_INDICATOR = $"(ansi cyan)❯(ansi reset) "

# Multiline prompt indicator
$env.PROMPT_MULTILINE_INDICATOR = $"(ansi blue_bold)::: (ansi reset)"
$env.config.show_banner = false
