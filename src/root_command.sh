declare -g dash
declare -g underscore
declare -g period
declare -g new_name
declare -g PATH_BASE

dash="${args[--dash]}"
underscore="${args[--underscore]}"
period="${args[--period]}"

if [ -p /dev/stdin ]; then
  readarray -t files
elif [[ -n "${args[source]}" ]]; then
  IFS=',' read -ra files <<<"${args[source]}"
else
  echo "Error: No valid input provided. Please provide a file name."
  exit 1
fi

for f in "${files[@]}"; do
  if [[ -z "$f" ]]; then
    echo "Error: file names cannot be empty." >&2
    exit 1
  elif [[ -d "$f" ]]; then
    echo "Error: '$f' is a directory" >&2
    exit 1
  else
    fext=".${f##*.}"
    fnoext="${f%.*}"
    if [[ $dash ]]; then
      # shellcheck disable=SC2001
      new_name=$(echo "${fnoext}" | sed 's/[^A-Za-z0-9-]/-/g')
      new_name="${new_name}${fext}"
    elif [[ $underscore ]]; then
      # shellcheck disable=SC2001
      new_name=$(echo "${fnoext}" | sed 's/[^A-Za-z0-9_-]/_/g')
      new_name="${new_name}${fext}"
    elif [[ $period ]]; then
      # shellcheck disable=SC2001
      new_name=$(echo "${fnoext}" | sed 's/[^A-Za-z0-9.-]/./g')
      new_name="${new_name}${fext}"
    else
      # shellcheck disable=SC2001
      new_name=$(echo "${fnoext}" | sed 's/[^A-Za-z0-9-]//g')
      new_name="${new_name}${fext}"
    fi
  fi
  mv "$f" "$new_name"
  echo "File: '$f' was moved to $new_name"
done

exit 0
