package QuizMaker::Problem;

use strict;
use warnings;
use Carp;

=head1 NAME

QuizMaker::Problem - a 'Problem' in the QuizMaker system

=head1 SYNOPSIS

  # load a problem from a file
  $qzp = QuizMaker::Problem->load_file($file);

  # data values are accessed directly
  $q = $qzp->{'question'};
  # see load_file() for a listing of available values

=head1 DESCRIPTION

QuizMaker::Problem provides operations for the problems in the
QuizMaker system.

=head1 OPERATIONS

=cut

# {{{ load_file

=head2 QuizMaker::Problem->load_file($file)

  $qzp = QuizMaker::Problem->load_file($file);

    Returns: defined object on success, undef otherwise

Load the problem defintion as defined by the Perl code in $file.

The data values are accessible in the object using
reference syntax ($qzp->{'key'}).

  print $qzp->{'question'};

 - $question   - the question in LaTeX format
 - $answer     - the answer in LaTeX format
 - $short_desc - short description, useful for summaries
 - $par_time   - time it should take to answer the problem
                 in HH:MM:SS format.
 - @tags       - list of tags for this question
 - $workspace  - amount of \vspace (LaTeX) to provide for solving the problem
 - $ref        - reference to where this problem originated
 - $author     - author of this problem

=cut

sub load_file {
    my $class = shift;
	my $file = shift;

    unless (open(IN_FILE, "< $file")) {
		carp "Unable to open $file $!\n";
        return;
    }

    my $code = "";
	while (<IN_FILE>) { $code .= $_ };
    close(IN_FILE);

    our (	$question,
			$answer,
			$short_desc,
			$par_time,
			@tags,
			$worklines,  # number of work lines, should use work space instead
			$workspace,
			$uuid,
        	$ref,
			$author);

	# set the default values
	undef $question;
	undef $answer;
	undef $short_desc;
	undef $par_time;
	undef @tags;
	undef $worklines;
	undef $workspace;
	undef $uuid;
	undef $ref;
	undef $author;

    my $res = eval($code);
    unless ($res) {
        print STDERR "Error executing eval: $@".
            "Check for syntax errors in the problem definition.\n";
        return;
    }

	# Some old problem specs use $worklines.
	# Here we are attempting to convert to $workspace
	# which uses \vspace in LaTeX.
	# I have not found an exact way to use the text height
	# so this is an approximation.
	if (! defined $workspace) {
		$workspace = ($worklines) . "em";
	}

	# fix escapes so LaTeX works correctly
    $question =~ s/[\\][\s]*$/ \\\\/;

    bless {
        file       => $file,
        question   => $question,
        answer     => $answer,
        short_desc => $short_desc,
        par_time   => $par_time,
        tags       => [@tags],
        workspace  => $workspace,
		uuid       => $uuid,
        ref        => $ref,
        author     => $author,
		#data_format => 'Perl',
    }, $class;
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
