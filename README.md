# bash-github-backup

[![Lint](https://github.com/loganmarchione/bash-github-backup/actions/workflows/lint.yml/badge.svg)](https://github.com/loganmarchione/bash-github-backup/actions/workflows/lint.yml)

Bash script to backup all GitHub repositories for a given username to a `tar.gz` file.

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
    -l
      Location where backup tar.gz file will be saved (e.g., /home/logan/test1)

    -u
      GitHub username (e.g., loganmarchione)

Example:
    ./github_backup.sh -l /home/logan/test1 -u loganmarchione
```

⚠️ WARNING ⚠️

The repos are cloned with [`--mirror`](https://git-scm.com/docs/git-clone#Documentation/git-clone.txt---mirror), so they are a bare repo. After decompressing, you will not be able to `cd` into each directory and see your files. Instead, you'll see what is normally inside the `.git` directory.

To see your files, you'll need to either:

- clone the mirrored repo to a new local repo

  ```
  git clone mirrored-repo new-repo
  ```

OR

- push the mirrored repo to a new remote repo

  ```
  cd mirrored-repo
  git push --mirror https://server.com/username/new-repo.git
  ```


# TODO
- [ ] Test with more than 100 repos (I think this might be an API limit)
- [x] Add linting
- [ ] Add backups for issues, wiki, etc...
- [ ] Check for HTTP response from curl, error based on HTTP code
