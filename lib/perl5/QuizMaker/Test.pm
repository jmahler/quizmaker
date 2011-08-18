package QuizMaker::Test;

use strict;
use warnings;
use Carp;

use QuizMaker::Problem;

=head1 NAME

QuizMaker::Test - a 'Test' in the QuizMaker system

=head1 SYNOPSIS

  # load a test definition from a file
  # and all of its problems
  $qzt = QuizMaker::Test->load_file($file);

  # data values are accessed directly
  @problems = @{$qzt->{'problems'}};
  # see load_file() for a listing of available values

=head1 DESCRIPTION

QuizMaker::Test provides operations for the problems in the
QuizMaker system.

=head1 OPERATIONS

=cut

# {{{ load_file

=head2 QuizMaker::Test->load_file($file)

  $qzp = QuizMaker::Test->load_file($file);

    Returns: defined object on success, undef otherwise

Load the test defintion as defined by the Perl code in $file.

The data values are accessible in the object using
reference syntax ($qzp->{'key'}).

  print $qzp->{'question'};

 - $class      - name of the class (e.g. MATH-40)
 - $term       - term of class (e.g. Spring 2011)
 - $title
 - $instructions
 - @problem_files
 - @problems   - loaded Problem objects

=cut

sub load_file {
    my $_class = shift;
	my $file = shift;

    unless (open(IN_FILE, "< $file")) {
		carp "Unable to open $file $!\n";
        return;
    }

    my $code = "";
	while (<IN_FILE>) { $code .= $_ };
    close(IN_FILE);

    our (	$class,
			$term,
			$title,
			$instructions,
			@problems,    # problem file names
		);

    my $res = eval($code);
    unless ($res) {
        print STDERR "Error executing eval: $@".
            "Check for syntax errors in the test definition.\n";
        return;
    }

	# fix escapes so LaTeX works correctly
    $instructions =~ s/[\\][\s]*$/ \\\\/;

	# load all the problems,
	my @problem_files = @problems;
	# @problems will be overwritten to store the objects
	for (my $i = 0; $i < @problem_files; $i++) {
		my $problem_file = $problem_files[$i];

		my $qzp = QuizMaker::Problem->load_file($problem_file);
		if (!$qzp) {
			carp "Error loading problem $i ('$problem_file'), ABORTED\n";
			return;
		}

		$problems[$i] = $qzp;
	}

    bless {
        class => $class,
        term => $term,
        title => $title,
        instructions => $instructions,
        problem_files => [@problem_files],
        problems => [@problems],
    }, $_class;
}
# }}}

=head1 VERSION

Refer to the parent module 'QuizMaker' for version information.

=head1 AUTHOR

Jeremiah Mahler <jmmahler@gmail.com>
CPAN ID: JERI
http://www.google.com/profiles/jmmahler#about

=head1 COPYRIGHT

Copyright (c) 2010, Jeremiah Mahler. All Rights Reserved.
This module is free software.  It may be used, redistributed
and/or modified under the same terms as Perl itself.

=head1 SEE ALSO

QuizMaker

=cut


1;
