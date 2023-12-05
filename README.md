CGA-Image-Viewer
================

This is a quick and dirty, image viewer made in Assembly that is designed specially for interlaced
and linear RAW CGA image data in mind.

I've created this tool way back in May of 2022 to improve my machine language skills, while experimenting
with various image file formats.

Requirements
------------
- [DOSBox](https://www.dosbox.com/) or [DOSBox-X](https://dosbox-x.com/)
- Borland Turbo Assembler/TASM v5.0 *(google is your friend)*

Usage
-----

### Compiling
```
# Install TASM in DOSBox (by default, the path for TASM should be "C:\TASM").

# Modify your AUTOEXEC file to configure "C:\TASM" and "C:\TASM\BIN" as the path
SET PATH=C:\TASM;C:\TASM\BIN

# Open "CGA.ASM" using a text editor, change the 'FileName' value to the name
of your file you want to open (by default, this is 'IMAGE.RAW').

# Compile the program as a (.COM) file.
tasm cga
tlink cga /t
```

### Decoding
```
# Decode "IMAGE.RAW" (default) or other filename that you have specified
prior to compiling.
cga.com
```

### More Information
- [RAW CGA Data (Modding Wiki)](https://moddingwiki.shikadi.net/wiki/Raw_CGA_Data)
