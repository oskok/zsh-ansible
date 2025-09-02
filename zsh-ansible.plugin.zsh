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

if type python3 >/dev/null; then
  for package in "${PACKAGES[@]}"; do
    $(which python3) -m pip install --upgrade pip
    $(which python3) -m pip install --upgrade ${package} --user
    rehash
  done
fi

if type molecule >/dev/null; then
  export MOLECULE_NO_LOG='false'
fi
