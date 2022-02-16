## Tricks specific to Git and Github

#### Starting a new git project (R) with version control
(as summarized [here](https://codehorizons.com/making-your-first-github-r-project/))

0. Set up git

After software updates, Xcode needs to be installed (MacOS) to enable git.

In terminal
```bash
git
```
OR
```bash
xcode-select --install
```
should trigger installation of the required command line tools.

Continue setup:

```bash
library(usethis)
use_git_config(user.name = "Jane Doe", user.email = "jane@example.com")
git_vaccinate()
```
github now requires a personal access token (PAT) instead of just username and password

```bash
create_github_token()
```
then to prompt its use:
```bash
gitcreds::gitcreds_set()
```
and finally to check everything:
```bash
usethis::git_sitrep()
```

1. Turn a new or existing directory into an R project with a .Rproj file

Use the R command line while in the correct directory to initialize:
```bash
git init
```
check for a git repo in chosen directory

2. On github make a new repo choosing to create from an existing directory and copy the code it gives you.

It is unclear from this point whether it is better to push or pull first. Some indexing of branches may be required to align first commit/pull

#### Removing files that have already been pushed or committed
(but keeping the local version)

From the project repo directory (for single file or whole folder):
```bash
git rm --cached <file>
git rm -r --cached <folder>
```
Removal will happen on next commit


#### Global ignore
Use terminal -ls -a to reveal hidden files and folders
From project repo directory:
```bash
nano /.git/info/exclude
```
edit this folder as you would ` .gitignore ` to exclude files and filetypes
you can also add .gitignore to the exclude file to keep it from showing up online in Github (though not necessarily advisable)
