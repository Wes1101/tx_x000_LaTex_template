# latexmk configuration for this template.
# Picked up automatically when latexmk runs in this directory (CLI, VS Code, IntelliJ, CI).

$pdf_mode = 1;                 # build a PDF via pdflatex
$out_dir  = 'build';           # all generated files go here (git-ignored)
$bibtex_use = 2;               # run biber and delete its files on `latexmk -C`

# \include{dir/file} writes dir/file.aux, so every source sub-directory must also exist
# inside the output directory. IDEs may pass their own output directory (e.g. IntelliJ: out/),
# so the directories are created right before every pdflatex run, in the directory in effect.
$pdflatex = 'internal pdflatex_with_dirs %O %S';
use File::Path qw(make_path);
sub pdflatex_with_dirs {
    foreach my $dir (glob('*/')) {
        $dir =~ s{/$}{};
        make_path("$out_dir/$dir") unless $out_dir eq $dir;
    }
    return system('pdflatex', '-interaction=nonstopmode', '-file-line-error', '-synctex=1', @_);
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
