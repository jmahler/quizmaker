package QuizMaker;

use strict;
use warnings;
use Carp;

use QuizMaker::Problem;

use vars qw($VERSION);
$VERSION = '0.01';
require 5.6.1;

=head1 NAME

QuizMaker - Perl 5 module for the QuizMaker system

=head1 SYNOPSIS

  # create new test
  $qzm = QuizMaker->new('title' => 'My First Quiz');

  # load a problem from a file
  $file = '/path/to/my/problems/prob01-math.pl';
  $qzp = QuizMaker::Problem->load_file($file);

  # add one problem to the test (would normally add many)
  $qzm->add_problem($qzp);

  # generate and display the LaTeX output
  $tex = $qzm->to_tex();
  print $tex;

=head1 DESCRIPTION

QuizMaker provides operations for the QuizMaker project which
is an open source student testing system.

=head1 OPERATIONS

=cut

# {{{ new

=head2 QuizMaker->new()

  $qzm = QuizMaker->new(%config);

    Returns: defined object on success, undef otherwise

Builds an object which represents a test.

=cut

# TODO - check for config values in ~/.quizmaker

sub new {
    my $class = shift;

    if (0 != @_ and 2 % @_) {
        carp "odd number of arguments";
        return;
    }

    my %config;
    if (@_) {
        %config = @_;
    }

    my $dbi_str = "dbi:Pg:dbname=quizmaker";

    if (exists $config{dbi_str}) {
        $dbi_str = $config{dbi_str};    
    }

    my $dbh = DBI->connect($dbi_str);
    if (! $dbh) {
        carp "Unable to create valid db connection.";
    }

    bless {
        title => '(un-titled)',
        disp_date => 'today',  # what date to display for the test
        %config,
        dbh => $dbh,
    }, $class;
}
# }}}

# {{{ load_file

=head2 load_file()

  $qzp = $qzm->load_file($file);

    Returns: defined object on success, undef otherwise

Loads a problem by calling QuizMaker::Problem::load_file
AND also associates the QuizMaker parent object
(which may be needed for database operations).

This does NOT load a test from a file.

=cut

sub load_file {
    my $self = shift;
    my $file = shift;

    my $qzp = QuizMaker::Problem->load_file($file);
    unless ($qzp) {
        carp "Unable to load problem from file: '$file'.";
        return;
    }

    # associate with the parent object
    $qzp->{qzm} = $self;

    return $qzp;
}
# }}}

# {{{ load_db

=head2 load_db()

  $qzp = $qzm->load_db($problem_id);

    Returns: defined object on success, undef otherwise

Loads a Problem by calling QuizMaker::Problem::load_db

=cut

sub load_db {
    my $self = shift;
    my $problem_id = shift;

    QuizMaker::Problem->load_db($self, $problem_id);
}
# }}}

# {{{ add_problem

=head2 $qzm->add_problem($qzp)

  $res = $qzm->add_problem($qzp)

    Returns: TRUE on success, undef otherwise

Adds an addition problem to the test.

=cut

sub add_problem {
    my $self = shift;
    my $qzp = shift;

    unless (defined $qzp) {
        carp "Cannot add an undefined problem.";
        return;
    }

    push @{$self->{problems}}, $qzp;

    return 1;
}
# }}}

# {{{ to_tex

=head2 to_tex()

  $tex = $qzm->to_tex('with answers');
  $tex = $qzm->to_tex(); # no answers

Produce LaTeX output of the entire test either with or without the answers.

=cut

sub to_tex {
    my $self = shift;
    my $answersp = shift;

    my $title = $self->{title};
    my $disp_date = $self->{disp_date};

    my $tex;

    $tex .= $self->tex_header();

    # title, test info
    $tex .= "\\begin{flushleft}\n";

    # title (date)
    if ($disp_date eq 'today') {
        $tex .= "$title (\\today)\n";
    } else {
        carp "Unknown disp_date: '$disp_date'";
        return;
    }

    $tex .= "\\end{flushleft}\n";

    my $n = 1;
    foreach my $qzp (@{$self->{problems}}) {
        #$tex .= "% Problem: $n START\n";
        $tex .= "\n";

        $tex .= $qzp->to_tex($n, $answersp);
        #$tex .= "% Problem: $n END\n";
        $tex .= "\n";

        $n++;
    }

    $tex .= $self->tex_footer();

    return $tex;
}
# }}}

# {{{ tex_header, tex_footer

=head2 tex_header(), tex_footer()

  print $qzm->tex_header();
  print $qzm->to_text();
  print $qzm->tex_footer();

Functions such as to_tex do not generate all the required output
for a complete LaTeX document.
tex_header, tex_footer are used to complete this output.

=cut

sub tex_header {

"\\documentclass[fleqn]{article}
\\usepackage{vmargin}
\\usepackage{amsmath}
\\usepackage{graphicx}
\\usepackage{hyperref}
\\usepackage{needspace}
\\parindent=0in

\\begin{document}\n";
}

sub tex_footer {

"\n\\end{document}\n";

}

# }}}

# {{{ get_tests

=head2 get_tests()

  @tests = $qzm->get_tests();

Get data about all tests.

=cut

sub get_tests {
    my $self = shift;

    my $dbh = $self->{dbh};
    if (! $dbh) {
        carp "No valid db connection present.";
        return;
    }

    my @cols = qw(test_id author dsc create_date finished);
    my $sel_tests_sql = "SELECT test_id, author, dsc, create_date, finished FROM Tests ;";
    my $sel_tests_sth = $dbh->prepare($sel_tests_sql);
    if (! $sel_tests_sth) {
        carp "Unable to prepare to SELECT FROM Tests.";
        return;
    }

    my $rv = $sel_tests_sth->execute();
    if (! $rv) {
        carp "Unable to SELECT FROM Tests.";
        return;
    }

    my @tests;
    while (my $row = $sel_tests_sth->fetchrow_hashref) {
        push @tests, $row;
    }

    return @tests;
}
# }}}

# {{{ get_tags

=head2 get_tags()

  @tests = $qzm->get_tags();

Get all tags.

=cut

sub get_tags {
    my $self = shift;

    my $dbh = $self->{dbh};
    if (! $dbh) {
        carp "No valid db connection present.";
        return;
    }

    my $sql =
        "SELECT tag,
            (SELECT count(*) FROM ProblemTags AS PT
                WHERE PT.tag_id = Tags.tag_id) AS count
            FROM Tags
            ORDER BY count DESC ;";

    my $sth = $dbh->prepare($sql);
    if (! $sth) {
        carp "Unable to PREPARE.";
        return;
    }

    my $rv = $sth->execute();
    if (! $rv) {
        carp "Unable to SELECT FROM Tags.";
        return;
    }

    my @tags;
    while (my $row = $sth->fetchrow_hashref) {
        push @tags, $row;
    }

    return @tags;
}
# }}}

# {{{ create_test

=head2 create_test()

  $res = $qzm->create_test($description);

Create a new test.

=cut

sub create_test {
    my $self = shift;
    my $dsc = shift;

    my $dbh = $self->{dbh};
    if (! $dbh) {
        carp "No valid db connection present.";
        return;
    }

    my $insert_test_sql =
        "INSERT INTO Tests (finished, dsc) VALUES (FALSE, ?) ;";

    $dbh->do($insert_test_sql, undef, $dsc);
}
# }}}

# {{{ delete_test

=head2 delete_test()

  $res = $qzm->delete_test($test_id);

=cut

sub delete_test {
    my $self = shift;
    my $test_id = shift;

    my $dbh = $self->{dbh};
    if (! $dbh) {
        carp "No valid db connection present.";
        return;
    }

    my $sql = "DELETE FROM Tests WHERE test_id = ? ;";

    $dbh->do($sql, undef, $test_id);
}
# }}}

# {{{ finish_test

=head2 finish_test()

  $res = $qzm->finish_test($test_id);

=cut

sub finish_test {
    my $self = shift;
    my $test_id = shift;

    my $dbh = $self->{dbh};
    if (! $dbh) {
        carp "No valid db connection present.";
        return;
    }

    my $sql = "UPDATE Tests SET finished = TRUE WHERE test_id = ? ;";

    $dbh->do($sql, undef, $test_id);
}
# }}}

=head1 VERSION

This document refers to QuizMaker version 0.01.

=head1 AUTHOR

Jeremiah Mahler <jmmahler@gmail.com>
CPAN ID: JERI
http://www.google.com/profiles/jmmahler#about

=head1 COPYRIGHT

Copyright (c) 2010, Jeremiah Mahler. All Rights Reserved.
This module is free software.  It may be used, redistributed
and/or modified under the same terms as Perl itself.

=head1 SEE ALSO

QuizMaker::Problem

=cut

1;
