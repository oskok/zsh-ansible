# =============================================================================
#   ZSH ANSIBLE PLUGIN
# =============================================================================

_zsh_package_ansible() {

  # Список пакетов для установки
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

  # Устанавливаем или обновляем PIP до актуальной версии
  $(which python3) -m pip install --upgrade pip --user > /dev/null 2>&1 &

  # Устанавливаем или обновляем ANSIBLE и его дополнения
  for package in "${PACKAGES[@]}"; do
    $(which python3) -m pip install --upgrade ${package} --user > /dev/null 2>&1 &
  done
  rehash
}

# Вызов установки в фоне
if type python3 >/dev/null; then
  setopt LOCAL_OPTIONS NO_NOTIFY NO_MONITOR
  _zsh_package_ansible
  disown &>/dev/null
fi

# Переменные
if type molecule >/dev/null; then
  export MOLECULE_NO_LOG='false'
fi
