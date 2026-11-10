# latexmk configuration for this template.
# Picked up automatically when latexmk runs in this directory (CLI, VS Code, IntelliJ, CI).

$pdf_mode = 1;                 # build a PDF via pdflatex
$out_dir  = 'build';           # all generated files go here (git-ignored)
$bibtex_use = 2;               # run biber and delete its files on `latexmk -C`

# Show errors as file:line:message and never stop at an interactive prompt.
$pdflatex = 'pdflatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S';

# \include{dir/file} writes dir/file.aux, so every source sub-directory
# must also exist inside the output directory.
use File::Path qw(make_path);
foreach my $dir (glob('*/')) {
    $dir =~ s{/$}{};
    make_path("$out_dir/$dir") unless $dir eq $out_dir;
}

# Print all errors and warnings from the LaTeX log once the run is finished,
# so they are not buried in the build output. Pure Perl: works on every OS.
END {
    foreach my $log (glob("$out_dir/*.log")) {
        open(my $fh, '<', $log) or next;
        my @hits = grep { /^\S+:\d+:|^!|(LaTeX|Package|Class) .*Warning|^Overfull|^Underfull/ } <$fh>;
        close($fh);
        next unless @hits;
        print "\n==== Errors and warnings ($log) ====\n", @hits, "====\n";
    }
}
