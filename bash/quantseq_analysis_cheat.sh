### Screen management #
screen -r -d sessioname # reopen attached sessions #
screen -S sessioname # create session with custom name #
Ctrl-a [ # go into scrollback mode to see more of a screen's history
Ctrl-a-d # detach from screen
killall screen # DO NOT SUDO! # kill all screen sessions (that you have permission to modify)


### In the case of needing to use an older version of Java #
sudo apt-get update
sudo apt-get openjdk-8-jre # installing older version of Java #
sudo update-alternatives --config java # adding older version of Java to root path #

### Creating soft links to data #
ln -s /PATH/TO/ORIGINAL/FOLDER/*.fq.gz . # This creates a soft link of all the .fq.gz files in original directory, in current directory #

### Changing directory ownership #

sudo chown -R ffi007:ffi007 . # Changing ownership of all current directories (-R) #


### Remember to change permissions for bash script execution #
chmod 755 bashcript.sh

### And for the filelist.txt #
chmod 755 filelist.txt

### File and directory management #

### Find a file #
find /data -name uniprot_modelfish_backtranseq.fasta # find the fasta file in the /data directory and all sub-directories #

### Print line X of GFF file #
sed -n Xp GFF_FILE.gff 

### Selecting lines of interest in a GFF file #
grep transcript_id inputGFFfile > outputGFFfile # all lines containing 'transcript_id' #

grep -A20 -B20 target file.txt  # 20 lines before and after the target

### Counting lines in a file #
wc -l someGFFfile.gff

### Selecting lines from a txt file #
awk '$2 > 0' FILE.txt > SOMEOUTPUTFILE.txt # Selecting lines where column 2 has a value > 0 #

### Print selected columns from a txt file #
awk '{print $x,$y}' inputfile > outputfile # For x and y columns #

### Reading a few lines from a .gz file #
zcat < someFQ.GZfile | head

### Read count in fq.gz file #
zcat file.fq.gz | echo $((`wc -l`/4))

### Rename files large number of files #

rename 's/abc/xyz/' * # Rename files where 'abc' shows up, and change it to 'xyz' #

### Find a specific file/program #
find / -iname multiqc # might have to sudo #

### Indexing bam file using samtools #
samtools index bamfile.bam

### View bam file #
samtools view -h bamfile.bam


To write the output of a command to a file, there are basically 10 commonly used ways.
Overview:

          || visible in terminal ||   visible in file   || existing
  Syntax  ||  StdOut  |  StdErr  ||  StdOut  |  StdErr  ||   file   
==========++==========+==========++==========+==========++===========
    >     ||    no    |   yes    ||   yes    |    no    || overwrite
    >>    ||    no    |   yes    ||   yes    |    no    ||  append
          ||          |          ||          |          ||
   2>     ||   yes    |    no    ||    no    |   yes    || overwrite
   2>>    ||   yes    |    no    ||    no    |   yes    ||  append
          ||          |          ||          |          ||
   &>     ||    no    |    no    ||   yes    |   yes    || overwrite
   &>>    ||    no    |    no    ||   yes    |   yes    ||  append
          ||          |          ||          |          ||
 | tee    ||   yes    |   yes    ||   yes    |    no    || overwrite
 | tee -a ||   yes    |   yes    ||   yes    |    no    ||  append
          ||          |          ||          |          ||
 n.e. (*) ||   yes    |   yes    ||    no    |   yes    || overwrite
 n.e. (*) ||   yes    |   yes    ||    no    |   yes    ||  append
          ||          |          ||          |          ||
|& tee    ||   yes    |   yes    ||   yes    |   yes    || overwrite
|& tee -a ||   yes    |   yes    ||   yes    |   yes    ||  append

List:

    command > output.txt

    The standard output stream will be redirected to the file only, it will not be visible in the terminal. If the file already exists, it gets overwritten.

    command >> output.txt

    The standard output stream will be redirected to the file only, it will not be visible in the terminal. If the file already exists, the new data will get appended to the end of the file.

    command 2> output.txt

    The standard error stream will be redirected to the file only, it will not be visible in the terminal. If the file already exists, it gets overwritten.

    command 2>> output.txt

    The standard error stream will be redirected to the file only, it will not be visible in the terminal. If the file already exists, the new data will get appended to the end of the file.

    command &> output.txt

    Both the standard output and standard error stream will be redirected to the file only, nothing will be visible in the terminal. If the file already exists, it gets overwritten.

    command &>> output.txt

    Both the standard output and standard error stream will be redirected to the file only, nothing will be visible in the terminal. If the file already exists, the new data will get appended to the end of the file..

    command | tee output.txt

    The standard output stream will be copied to the file, it will still be visible in the terminal. If the file already exists, it gets overwritten.

    command | tee -a output.txt

    The standard output stream will be copied to the file, it will still be visible in the terminal. If the file already exists, the new data will get appended to the end of the file.

    (*)

    Bash has no shorthand syntax that allows piping only StdErr to a second command, which would be needed here in combination with tee again to complete the table. If you really need something like that, please look at "How to pipe stderr, and not stdout?" on Stack Overflow for some ways how this can be done e.g. by swapping streams or using process substitution.

    command |& tee output.txt

    Both the standard output and standard error streams will be copied to the file while still being visible in the terminal. If the file already exists, it gets overwritten.

    command |& tee -a output.txt

    Both the standard output and standard error streams will be copied to the file while still being visible in the terminal. If the file already exists, the new data will get appended to the end of the file.







