# =============================================================================
#   ZSH ANSIBLE PLUGIN
# =============================================================================

_zsh_package_pip() {
  $(which python3) -m pip install --upgrade pip --user &>/dev/null
  rehash
}

_zsh_package_ansible() {
    typeset -r PACKAGES=(
      'ansible'
      'ansible-lint'
      'molecule'
      'molecule-docker'
      'tox'
      'tox-ansible'
      'hvac'
      'dnspython'
      'jmespath'
      'urllib3<2.0'
    )

  for package in "${PACKAGES[@]}"; do
    $(which python3) -m pip install --upgrade ${package} --user &>/dev/null
    rehash
  done
}

if type python3 >/dev/null; then
  # setopt LOCAL_OPTIONS NO_NOTIFY NO_MONITOR
  _zsh_package_pip
  _zsh_package_ansible
  # disown &>/dev/null
fi

if type molecule >/dev/null; then
  export MOLECULE_NO_LOG='false'
fi
