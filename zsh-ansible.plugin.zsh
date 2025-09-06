# =============================================================================
#   ZSH PLUGIN
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
  if ! type ansible >/dev/null; then
    $(which python3) -m pip install --upgrade pip --user
  else
    $(which python3) -m pip install --upgrade pip --user > /dev/null 2>&1 &
  fi

  # Устанавливаем или обновляем ANSIBLE и его дополнения
  for package in "${PACKAGES[@]}"; do
    if ! type ansible >/dev/null; then
      $(which python3) -m pip install --upgrade ${package} --user
    else
      $(which python3) -m pip install --upgrade ${package} --user > /dev/null 2>&1 &
    fi
  done
  rehash

  if type ansible-galaxy >/dev/null; then
    ansible-galaxy collection install community.docker --force > /dev/null 2>&1 &
    ansible-galaxy collection install community.general --force > /dev/null 2>&1 &
  fi
}

# Вызов установки в фоне
if type python3 >/dev/null; then
  _zsh_package_ansible
fi

# Переменные
if type molecule >/dev/null; then
  export MOLECULE_NO_LOG='false'
fi
