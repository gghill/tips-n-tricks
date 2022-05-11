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

     - File > New Project > Existing Directory

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
```
nano /.git/info/exclude
```
edit this folder as you would ` .gitignore ` to exclude files and filetypes
you can also add .gitignore to the exclude file to keep it from showing up online in Github (though not necessarily advisable)


#### Removing or editing a bad commit (such as committing a file that is too large)
(as described [here](https://medium.com/analytics-vidhya/tutorial-removing-large-files-from-git-78dbf4cf83a))

*All of these commands can be typed into the terminal in R studio or in your system's command prompt, but make sure you are in the project directory.*

POV: you're wrapping up a session and you try to push your most recent commit, which involved bringing in a new data file, and after the push taking longer than usual you see:
```
remote: error: GH001: Large files detected. You may want to try Git Large File Storage - https://git-lfs.github.com
remote: error: Trace: 08740bd2fb02f980041be67b73e715a9
remote: error: See http://git.io/iEPt8g for more information.
remote: error: File too_big_file.csv is 218.83 MB; this exceeds GitHub's file size limit of 100.00 MB
To https://github.com/hoffm386/git-large-file-example.git
! [remote rejected] master -> master (pre-receive hook declined)
error: failed to push some refs to 'https://github.com/hoffm386/git-large-file-example.git'
```

First, we will need the command line to open some files, so we need to specify an editor. 
```
git config --global core.editor notepad 
# you can put any application here, such as sublime, vim, emacs, etc.
```
If the commit you need to fix is the last commit, it is pretty straightforward:
```
git rm --cached too_big_file.csv
git commit --amend -C HEAD
```
You should be able to push now!

If the bad commit was not the most recent, we have to dig a little deeper.
```
git log --oneline
```
This shows your commit history and we are looking to identify the commit ID of the last good commit:
```bash
de69e51 preliminary exploratory data analysis
d1bfae6 download too_big_file.csv
8464da4 update README
48f7303 Initial commit
```
In this case it looks like ```8464da4 update README``` is our target.
```
git rebase -i 8464da4
```
That will open a file in the git editor we specified at the beginning. Only the lines without "#" are important, the rest is just instructions.
```
pick d1bfae6 download too_big_file.csv
pick de69e51 preliminary exploratory data analysis
# Rebase 8464da4..099e6e4 onto 8464da4 (3 commands)
#
# Commands:
# p, pick <commit> = use commit
# r, reword <commit> = use commit, but edit the commit message
# e, edit <commit> = use commit, but stop for amending
# s, squash <commit> = use commit, but meld into previous commit
# f, fixup <commit> = like "squash", but discard this commit's log message
# x, exec <command> = run command (the rest of the line) using shell
# b, break = stop here (continue rebase later with 'git rebase --continue')
# d, drop <commit> = remove commit
# l, label <label> = label current HEAD with a name
# t, reset <label> = reset HEAD to a label
# m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
# .       create a merge commit using the original merge commit's
# .       message (or the oneline, if no original merge commit was
# .       specified). Use -c <commit> to reword the commit message.
#
# These lines can be re-ordered; they are executed from top to bottom.
#
# If you remove a line here THAT COMMIT WILL BE LOST.
#
# However, if you remove everything, the rebase will be aborted.
#
# Note that empty commits are commented out
```
So we want to edit the bad commit and "pick" (keep without changing) any others, so we edit the file to read:

```
edit d1bfae6 download too_big_file.csv
pick de69e51 preliminary exploratory data analysis
```
Closing the file should give this message in the terminal:
```
Stopped at d1bfae6...  download data CSV
You can amend the commit now, with
  git commit --amend
Once you are satisfied with your changes, run
  git rebase --continue
  ```
Now we can continue as if the problem was in the most recent commit, deleting the cached version of the problem file.
  ```
git rm --cached too_big_file.csv
git commit --amend -C HEAD
```
If your commit was just adding the too big file, you will get a message like this:
```
interactive rebase in progress; onto 8464da4
Last command done (1 command done):
  edit d1bfae6 download data CSV
Next commands to do (2 remaining commands):
  pick de69e51 preliminary exploratory data analysis
  pick 099e6e4 update gitignore to ignore large data file
You are currently splitting a commit while rebasing branch 'master' on '8464da4'.
Untracked files:
  too_big_file.csv
No changes
You asked to amend the most recent commit, but doing so would make
it empty. You can repeat your command with --allow-empty, or you can
remove the commit entirely with "git reset HEAD^".
```
To fix this you can start your rebase over and ```drop``` instead of ```pick``` the bad commit OR simply allow for an empty commit.
``` bash
git commit --amend --allow-empty -C HEAD
```
Now your rebase should be on track (whether or not you had to allow empty)
```
interactive rebase in progress; onto 8464da4
Last command done (1 command done):
   edit d1bfae6 download data CSV
Next commands to do (2 remaining commands):
   pick de69e51 preliminary exploratory data analysis
   pick 099e6e4 update gitignore to ignore large data file
  (use "git rebase --edit-todo" to view and edit)
You are currently editing a commit while rebasing branch 'master' on '8464da4'.
  (use "git commit --amend" to amend the current commit)
  (use "git rebase --continue" once you are satisfied with your changes)
Untracked files:
  (use "git add <file>..." to include in what will be committed)
      csv_building_damage_assessment.csv
nothing added to commit but untracked files present (use "git add" to track)
  ```
So tell rebase to keep going.
  ```
  git rebase --continue
  ```
And celebrate when you see
  ```
  Successfully rebased and updated refs/heads/master.
  ```
Now you should be able to push from command line or Rstudio with no errors!
  
