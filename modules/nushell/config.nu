$env.config.buffer_editor = "nvim"

def "nix upgrade" [] {
  sudo nix flake update --flake /etc/nixos
}

def "nix update" [] {
  sudo nixos-rebuild switch --flake /etc/nixos#nixos
}

def "reboot windows" [] {
  sudo efibootmgr -n 0000;
  sudo reboot
}

# Edits the nixos config for the system
def "config nixos" [] {
  let editor = ($env.config.buffer_editor | default "nano")

  cd "/etc/nixos";
  ^$editor .
}

def "nix clean" [] {
  sudo nix profile wipe-history;
  sudo nix store gc -v;
  sudo nix store optimise;
}

# let carapace_completer = {|spans| carapace $spans.0 nushell ...$spans | from json }

$env.config = {
  show_banner: false,
  completions: {
    case_sensitive: false # case-sensitive completions
    quick: true    # set to false to prevent auto-selecting completions
    # artial: true    # set to false to prevent partial filling of the prompt
    algorithm: "fuzzy"    # prefix or fuzzy
    external: {
      # set to false to prevent nushell looking into $env.PATH to find more suggestions
      enable: true
      # set to lower can improve completion performance at the cost of omitting some options
      max_results: 100
      # completer: $carapace_completer # check 'carapace_completer'
    }
  }
}

$env.PATH = ($env.PATH | split row (char esep) | append /usr/bin/env)
