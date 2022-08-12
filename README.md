# bash-github-backup

[![CI](https://github.com/loganmarchione/bash-github-backup/actions/workflows/main.yml/badge.svg)](https://github.com/loganmarchione/bash-github-backup/actions/workflows/main.yml)

Bash script to backup all GitHub repositories for a given username to a tar.gz file.

## Overview
I trust GitHub (and Microsoft) to not go down or lose my code (I'm sure they have backups in Azure 😅). However, recently, GitHub had to comply with the [Tornado Cash sanction](https://www.theregister.com/2022/08/10/github_tornado_cookies/) and remove all Tornado Cash code as well as the developer's accounts.

This script is my first attempt to backup my GitHub data.

## Requirements
Should work with any Linux distro with standard tools installed (curl, tar, etc...). Specifically requires: 
- `git`
- `jq`

## Usage
```
Usage:
    ./github_backup.sh -l location_of_backup_file -u github_user_name

Arguments:
    -u
      GitHub username (e.g., loganmarchione)

    -l
      Location where backup tar.gz file will be saved (e.g., /home/logan/test1)

Example:
    ./github_backup.sh -l /home/logan/test1 -u loganmarchione
```

# TODO
- [ ] Test with more than 100 repos (I think this might an an API limit)
- [ ] Add linting