if [[ ! -o interactive ]]; then
    return
fi

compctl -K _istioctlenv istioctlenv

_istioctlenv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(istioctlenv commands)"
  else
    completions="$(istioctlenv completions ${words[2,-2]})"
  fi

  reply=(${(ps:\n:)completions})
}
