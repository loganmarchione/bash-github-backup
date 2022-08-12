#!/bin/bash

usage() {
  printf "
Usage:
    $0 -l location_of_backup_file -u github_user_name

Arguments:
    -u
      GitHub username (e.g., loganmarchione)

    -l
      Location where backup tar.gz file will be saved (e.g., /home/logan/test1)

Example:
    $0 -l /home/logan/test1 -u loganmarchione

"
  exit 1
}

while getopts ":l:u:" opt; do
  case "${opt}" in
    l)
      location=${OPTARG}
      ;;
    u)
      username=${OPTARG}
      ;;
    :)
      usage
      ;;
    *)
      usage
      ;;
  esac
done
shift $((OPTIND -1))

# Set generic variables
hostname=$(uname -n)
datetime=$(date +%Y%m%d_%H%M)
logfile=/tmp/generate_backups.log

# If arguments aren't set, fail
if [[ -z "$location" ]] || [[ -z "$username" ]]; then
  printf "ERROR: Missing -l or -u, exiting...\n"
  usage
  exit 1
else
  printf "STATE: Found arguments, continuing...\n"
fi

# If jq isn't installed, fail
if ! [[ -x "$(command -v jq)" ]]; then
  printf "ERROR: jq is not installed, exiting...\n"
  exit 1
else
  printf "STATE: Found jq, continuing...\n"
fi

# If git isn't installed, fail
if ! [[ -x "$(command -v git)" ]]; then
  printf "ERROR: git is not installed, exiting...\n"
  exit 1
else
  printf "STATE: Found git, continuing...\n"
fi

# If directory doesn't exist, create it
if ! [[ -d "${location}" ]]; then
  printf "WARN:  Backup directory does not exist, creating...\n"
  mkdir -p "${location}"
else
  printf "STATE: Backup directory already exists, continuing...\n"
fi

# Make the curl request
repo_names=$(curl --silent --show-error https://api.github.com/users/"${username}"/repos | jq -r '.[].name')

count_repo_names=$(echo "${repo_names}" | wc -l )
printf "STATE: Found ${count_repo_names} repos...\n"

printf "STATE: Starting backup...\n"
temp_dir="/tmp/bash-github-backup"
mkdir -p "${temp_dir}"
while IFS= read -r line; do
  git clone --mirror https://github.com/"${username}"/"${line}".git "${temp_dir}"/"${line}"
done <<< "${repo_names}"

printf "STATE: Creating tar.gz file...\n"
tar -czf "${location}"/github_backup_"${datetime}".tar.gz "${temp_dir}"

printf "STATE: Deleting temp directory...\n"
find "${temp_dir}" -type d -prune -exec rm -rf "{}" \;