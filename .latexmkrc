# Force XeLaTeX - required by fontspec + Georgia in main.tex
$pdf_mode = 5;
$pdflatex = 'pdflatex -interaction=nonstopmode -file-line-error %O %S';
$xelatex = 'xelatex -interaction=nonstopmode -file-line-error %O %S';
