<p align="center">
<img src="logo/TeXWatchLogo.png" width="550">
</p>

This is a simple script used to watch and compile .tex files into pdfs on Unix systems.

I found myself frustrated by constantly having to save .tex files _and_ recompile them. So I wrote this script with the aim of increasing workflow by automatically recompiling your .tex files for you. It is best used alongside a pdf viewer such as Evince or Okular that will watch for changes in the pdf file.

### **Requirements**

It is best to have a full TeX distribution on your system. In particular, you should be able to run the **pdflatex** command.

<u>To install LaTeX on the following Linux distributions:</u>

Ubuntu/Debian/Mint: 

`sudo apt install texlive-full`

Fedora: 

`sudo dnf install texlive-scheme-full`

Arch/Manjaro:

`sudo pacman texlive-most`

### **Installation**

To download TeXWatch, run:
```bash
git clone https://github.com/gavinbarrett/TeXWatch
cd TeXWatch
```

Then add texwatch to a directory in your path.

`sudo cp texwatch /usr/local/bin/`

### **Usage**

Then you can run `texwatch {file}.tex` to watch and compile file.tex.
Output will be written to `{file}.pdf`.
