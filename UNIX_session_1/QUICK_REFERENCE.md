# Unix 1 quick reference

## Where am I?

| Task | Command |
|---|---|
| Show current user | `whoami` |
| Show host | `hostname` |
| Show working directory | `pwd` |
| List names | `ls` |
| Include hidden names | `ls -a` |
| Long listing | `ls -l` |
| Human-readable sizes | `ls -lh` |

## Moving through the filesystem

| Task | Command |
|---|---|
| Enter a directory | `cd directory` |
| Parent directory | `cd ..` |
| Home directory | `cd` or `cd ~` |
| Previous directory | `cd -` |
| Current directory | `.` |
| Parent directory | `..` |

An absolute path starts at `/`. A relative path starts from the current working directory.

## Open the current folder graphically

| Environment | Terminal command |
|---|---|
| macOS Finder | `open .` |
| Ubuntu desktop | `xdg-open .` |
| WSL in Windows File Explorer | `explorer.exe .` |

In Ubuntu Files, press `Ctrl+L` to reveal or enter a path. In macOS Finder, choose **View → Show Path Bar**. In WSL, Windows drives are usually mounted below `/mnt`, so `C:\Users\Student` usually appears as `/mnt/c/Users/Student`.

## Files and directories

| Task | Command |
|---|---|
| Create a directory | `mkdir name` |
| Create an empty file | `touch name.txt` |
| View a short text file | `cat name.txt` |
| Page through a file | `less name.txt` |
| Copy a file | `cp source destination` |
| Move or rename | `mv source destination` |
| Search inside files | `grep 'pattern' file.txt` |
| Find files recursively | `find . -type f -name '*.txt' -print` |

## Help

```bash
man ls
ls --help
```

Inside a manual page: `/term` searches, `n` advances to the next match, and `q` quits.

## Permissions

```text
r = 4    w = 2    x = 1
owner    group    others
```

| Task | Command |
|---|---|
| Inspect permissions | `ls -l` |
| Add owner execute | `chmod u+x script.sh` |
| Remove group/other write | `chmod go-w file.txt` |
| Set `rwxr-xr--` | `chmod 754 file` |

For a directory, execute permission means permission to traverse/access entries, not “run the directory”.

## Wildcards

| Pattern | Meaning |
|---|---|
| `*` | zero or more characters |
| `?` | exactly one character |
| `[abc]` | one character from the set |
| `[0-9]` | one digit |

Preview a pattern before using it with `cp`, `mv`, or `rm`:

```bash
printf '%s\n' ./*.txt
```

Quoting a glob makes it literal. Quoting a variable prevents word splitting and further glob expansion:

```bash
find . -name '*.txt'
printf '%s\n' "$file"
```

## Remote access

```bash
ssh username@host
exit
```

After connecting, commands operate on the remote machine until you log out. Check `hostname`, `whoami`, `pwd`, and the prompt whenever you are unsure.
