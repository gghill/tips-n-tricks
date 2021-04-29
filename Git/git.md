## Tricks specific to Git and Github

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
