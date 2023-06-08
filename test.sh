if ! dnsx >/dev/null 2>&1; then
    echo "dnsx returned exit code 1"
    # execute your command here
else 
  echo 'fuck'
fi