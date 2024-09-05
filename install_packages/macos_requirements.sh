function installMacOsPackages {
  installBrew
  installNerdFonts
  installRestPackages

  install_oh_my_zsh
  import_custom_zshrc
  import_iterm_cfg
}

function installBrew {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

function installNerdFonts {
  fonts_list=(
    font-fira-mono-nerd-font
    font-arimo-nerd-font
    font-code-new-roman-nerd-font
    font-cousine-nerd-font
    font-dejavu-sans-mono-nerd-font
    font-fira-code-nerd-font
    font-hack-nerd-font
    font-jetbrains-mono-nerd-font
  )

  brew tap homebrew/cask-fonts

  for font in "${fonts_list[@]}"; do
    brew install --cask "$font"
  done
}

function installRestPackages {
  packages=(
    neovim
    golang
    docker
    colima
    raycat
    alttab
    rectangle
    displaymenu
    hiddenbar
    tflint
    hashicorp/tap/terraform-ls
    jesseduffield/lazygit/lazygit
  )

  cask_packages=(
    iterm2
  )

  for pck in "${packages[@]}"; do
    brew install "$pck"
  done

  for pck in "${cask_packages[@]}"; do
    brew install --cask "$pck"
  done
}

function setUpLazygit {
  config_file="$HOME/Library/Application Support/lazygit/config.yml"
  config_line="disableStartupPopups: false"

  # Create directory if it doesn't exist
  mkdir -p "$(dirname "$config_file")"

  # Check if file exists and if the line is already present
  if [ -f "$config_file" ] && grep -q "$config_line" "$config_file"; then
    echo "The configuration is already present in the file."
  else
    # Append the line to the file
    echo "$config_line" >>"$config_file"
    echo "Configuration added successfully."
  fi
}

function import_iterm_cfg {
  local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  local profile_path="${script_dir}/dev_profile_iterm2.json"

  if [ -f "$profile_path" ]; then
    echo "Importing iTerm2 profile..."
    defaults write com.googlecode.iterm2 "LoadPrefsFromCustomFolder" -bool true
    defaults write com.googlecode.iterm2 "PrefsCustomFolder" -string "$script_dir"
    echo "iTerm2 profile imported successfully."
  else
    echo "Error: iTerm2 profile not found at $profile_path"
  fi
}

install_oh_my_zsh() {
  if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is already installed."
  else
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
}

import_custom_zshrc() {
  local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  local custom_zshrc="${script_dir}/my_zshrc"

  if [ -f "$custom_zshrc" ]; then
    echo "Importing custom .zshrc..."
    cp "$custom_zshrc" "$HOME/.zshrc"
    echo "Custom .zshrc imported successfully."
  else
    echo "Error: Custom .zshrc not found at $custom_zshrc"
  fi
}
