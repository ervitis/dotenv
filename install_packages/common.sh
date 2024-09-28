function installGolang {
  sudo curl -L https://raw.githubusercontent.com/udhos/update-golang/master/update-golang.sh | bash
}

function setUpGit {
  local gitconfig_path="$HOME/.gitconfig"

  # TODO change this text into git commands
  local config_text="[diff]
	tool = nvim
[difftool]
	prompt = false
[core]
	editor = nvim
[merge]
	tool = nvim
[mergetool \"nvim\"]
	cmd = nvim -c \"DiffviewOpen\"
[mergetool]
	prompt = false"

  # Check if .gitconfig exists, if not create it
  if [ ! -f "$gitconfig_path" ]; then
    touch "$gitconfig_path"
    echo "Created $gitconfig_path"
  fi

  # Append the configuration text to .gitconfig
  echo "$config_text" >>"$gitconfig_path"
  echo "Appended configuration to $gitconfig_path"
}

function neovimScriptUpdater {
  mkdir -p ~/scripts
  echo "nvim --headless \"+Lazy! sync\" +qa" >~/scripts/neovim_updater.sh
}

function installCommon {
  installGolang
  setUpGit
}
