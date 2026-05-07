# rmspaces

Remove spaces and any strange non-printables from file names or replace them with alternative separators.

```bash
rmspaces file\ name.txt #output: filename.txt
rmspaces file-name.txt #output: filename.txt
rmspaces -d file\ name.txt #output: file-name.txt
rmspaces -p file\ name.txt #output: file.name.txt
rmspaces -u file\ name.txt #output: file_name.txt
```
