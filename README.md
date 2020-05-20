## TeXWatch

This is a simple script used to watch and compile .tex files into pdfs on Unix systems.

### **Requirements**

It is best to have a full TeX distribution on your system. In particular, you should be able to run the **pdflatex** command.

To install on the following Linux distributions:

Ubuntu/Debian/Mint: 

`sudo apt install texlive-full`

Fedora: 

`sudo dnf install texlive-scheme-full`

Arch/Manjaro:

`sudo pacman texlive-most`

### **Installation**

To download TeXWatch, run:
```bash
git clone https://github.com/gavinbarrett/LatexWatcher
cd LatexWatcher
chmod +x texwatch.sh
```

Then add texwatch.sh to your path.

### **Usage**

Then you can run `texwatch {file}.tex` to watch and compile file.tex. Output will be written to {file}.pdf.
