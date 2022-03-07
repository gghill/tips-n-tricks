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

On Windows, just install the most recent version of Git via the internet or institutional software center.

Continue setup:

```bash
library(usethis)
# if you don't have the usethis package installed, you can install it using:
install.packages("usethis")
use_git_config(user.name = "Jane Doe", user.email = "jane@example.com")
# fill in your github username and associated email above
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
check for a git repo in chosen directory and restart R Studio. You should now see a "Git" tab.

2.  Commit! Commit your new files from R Studio, but don't push (yet).

3.  On github make a new repo choosing to create from an existing directory and copy the code it gives you, using the recommended settings for existing directories.

4. Paste the code github gives you into the R command line within your new R project. Should be something like:
```bash
git remote add origin https://github.com/YOURUSERNAME/example_project.git
git branch -M main
git push -u origin main
```
This comprises your first push to github. From now on, you can make changes online or locally and align them via commits. Always pull locally to make sure you are working on the most up to date version before pushing new commits!

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
