PROJECT_ROOT="/src"

if [[ ! -d "$PROJECT_ROOT" ]]; then
  echo "You didn't mount the project volume."
  return 1
fi

cd "$PROJECT_ROOT"

cat <<EOF
Welcome to the project.
EOF

