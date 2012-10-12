if [[ ! -o interactive ]]; then
    return
fi

compctl -K _change change

_change() {
  local word words completions
  read -cA words
  word="${words[2]}"

  if [ "${#words}" -eq 2 ]; then
    completions="$(change commands)"
  else
    completions="$(change completions "${word}")"
  fi

  reply=("${(ps:\n:)completions}")
}
