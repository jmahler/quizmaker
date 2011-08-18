package QuizMaker::Problem;

use strict;
use warnings;
use Carp;

=head1 NAME

QuizMaker::Problem - a 'Problem' in the QuizMaker system

=head1 SYNOPSIS

  # load a problem from a file
  $file = '/path/to/my/problems/prob01-math.pl';
  $qzp = QuizMaker::Problem->load_file($file);

  # The preferred way is to load using the parent object
  # so that a database object will be associated.
  $qzp = $qzm->load_file($file);

  # generate and display the LaTeX output
  print $qzp->to_tex();

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

This function assumes the perl code in $file is safe to load
and is from a trusted source (not from some anonymous person
on the internet.

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

    our ($question, $answer, $short_desc, $par_time, @tags, $worklines, $uuid,
        $ref, $author);

    my $res = eval($code);
    unless ($res) {
        print STDERR "Error executing eval: $@".
            "Check for syntax errors in the problem definition.\n";
        return;
    }

    $question =~ s/[\\][\s]*$/ \\\\/;

    bless {
        file => $file,
        question => $question,
        answer => $answer,
        short_desc => $short_desc,
        par_time => $par_time,
        tags => [@tags],
        worklines => $worklines,
        uuid => $uuid,
        ref => $ref,
        author => $author,
        data_format => 'Perl',
    }, $class;
}
# }}}

# {{{ to_tex

=head2 $qzp->to_tex();

  $tex = $qzp->to_tex(<seq>);
  $tex = $qzp->to_tex(<seq>, 'answer');
  $tex = $qzp->to_tex(<seq>, 'answer', 'preview);

    Returns: string on success, undef otherwise

Convert the problem representation to TeX format.
The generated output is not a complete TeX (LaTeX) document.
A header and footer are needed for a complete document
(See tex_header, tex_footer in QuizMaker).

=cut

# TODO - [jmmahler@gmail.com] Wed, 22 Sep 2010 13:38:11 -0700
# The formatting using \samepage does not work correctly
# and no other solution has been found.
# In some cases, when the verbatim section is long for the first
# problem, the entire first page will be blank except for the heading.
# Adjusting the size of the verbatim section resolves the problem.

sub to_tex {
    my $self = shift;
    my $seq = shift;
    my $answerp = shift;   # display answer? TRUE or FALSE
#    my $previewp = shift;  # is this a preview?  TRUE or FALSE

    my $tex;

#    if ($previewp) {
#        $tex .=
#        "\\begin{flushleft}\n".
#        "(Preview)\n".
#        "\\today\n".
#        "\\end{flushleft}\n".
#        "\n";
#    }

#    $tex .= "\\begin{samepage}\n";

    $tex .= "$seq.) ";
    # The 'question' defines if there is a space or other formatting
    # after the problem number.

    $tex .=  $self->{'question'} . "\n";

    $tex .= tex_worklines($self->{'worklines'});

#    $tex .= "\\end{samepage}\n";

    # This is a kludge to help formatting when tex_worklines is large.
    if (defined $self->{'worklines'} and $self->{'worklines'} > 40) {
        $tex .= "\\pagebreak\n";
    }

    if ($answerp) {
        $tex .= "\n*** ANSWER ***\n\n";

        $tex .= $self->{'answer'};

        $tex .= "\n";
    }

    return $tex;
}
# }}}

# {{{ tex_worklines

#
# Utility function to add additional lines to be used for working
# a problem.
#
# TODO - What about when the number of work lines exceeds a page?
#        Cannot simply perform a page break because what if the problem
#        starts at the bottom of a page?

sub tex_worklines {
	my $n = shift;

    # default number of lines
	if (! defined $n) {
		$n = 4
	}

    my $tex;

#    if ($n =~ /^pg([\d]+)$/) {
#   
#        for (my $i = 0; $i < $1; $i++) {
#            $tex .= "\\pagebreak\n";
#        }
#    } else {
        #$tex .= '\nopagebreak[4]' . "\n";

        #$tex .= "\\begin{samepage}\n";
        #$tex .= "\\end{samepage}\n";

        $tex .= "\n";

    #	$tex .= 
    #	"\n" .
        #$tex .= "\\needspace{$qworklines\\baselineskip}\n";
        $tex .= "\\begin{verbatim}\n";
    #	$tex .= "\\begin{itemize}\n";
        #$tex .= "begin verbatim\n";

        $tex .= "\n";
        for (my $i = 0; $i < $n; $i++) {
            $tex .= "\n";
            #$tex .= '\newpage' . "\n";
            #$tex .= '\\*' . "\n";
            #$tex .= "\\item{}";
        }

        #$tex .= "end verbatim\n";
        $tex .= "\\end{verbatim}\n";
    #	$tex .= "\\end{itemize}\n";
#    }

    return $tex;
}
# }}}

# {{{ to_db

=head2 $qzp->to_db();

Save the problem to the database.

 $rv = $qzp->to_db();
 if (! $rv) {
    die "unable to save!"
 }

=cut

sub to_db {
    my $self = shift;

    # This child object gets the database handle from the parent object.
    # But since it is only required for operations that use the database
    # check and make sure the handle is present.
    my $qzm = $self->{qzm};
    unless ($qzm) {
        carp " This Problem requires a parent (QuizMaker) object to be\n".
             " associated in order to perform database operations.\n";
        return;
    }

    my $dbh = $qzm->{dbh};
    unless ($dbh) {
        carp " This Problem requires a database object to be associated\n".
             " in the parent (QuizMaker) object in order to perform\n".
             " datbase operations.";
        return;
    }

	$dbh->begin_work();

    # {{{ update or insert?
    # If the problem is already stored it will be updated,
    # otherwise it will be created.
    #
    # Insert creates everything but update behaves like the following.
    #
    #   - tags are not modified, it is assumed that they may have
    #      been modified in the database and that these are the ones
    #      that should be kept.
    #  - file, dsc, par_time, ref, author are updated
    #
    my $update_else_insert;
    my $problem_id;

    unless ($self->{uuid} =~ /\w+/) {
        carp " A unique identifier (uuid) must be defined before a problem\n".
             " can be saved to the database.";
        return;
    }

	my $sel_problem_sql = "SELECT problem_id FROM Problems WHERE uuid = ? ;";
    my $problem_id_ref = $dbh->selectcol_arrayref($sel_problem_sql, {}, $self->{uuid});
    if (! defined $problem_id_ref) {
        carp "Error trying to SELECT from database.";
        return;
    }
    if (@$problem_id_ref > 0) {
        # UPDATE
        $problem_id = $problem_id_ref->[0];
        $update_else_insert = 1;
    } else {
        # INSERT
        $update_else_insert = 0;
    }
    # }}}

    # {{{ update/insert problem
    if ($update_else_insert) {
        my $update_problem_sql =
            "UPDATE Problems SET short_desc = ?, par_time = ?, ref = ?, author = ? WHERE problem_id = ?";
            #"UPDATE Problems SET dsc = ?, file = ?, par_time = ?, ref = ?, author = ? WHERE problem_id = ?";
        my $update_problem_sth = $dbh->prepare_cached($update_problem_sql);

        my $res = $update_problem_sth->execute(
                    $self->{short_desc},
                    #$self->{file},
                    $self->{par_time},
                    $self->{ref},
                    $self->{author},
                    $problem_id,
                );

        unless ($res) {
            carp "Unable to UPDATE problem.";
            $dbh->rollback();
            return;
        }
    } else {
        my $insert_problem_sql =
            "INSERT INTO Problems (short_desc, question, answer, par_time, uuid, ref, author) VALUES (?, ?, ?, ?, ?, ?, ?); ";
            #"INSERT INTO Problems (dsc, file, par_time, uuid, ref, author) VALUES (?, ?, ?, ?, ?, ?); ";
        my $insert_problem_sth = $dbh->prepare_cached($insert_problem_sql);

        my $res = $insert_problem_sth->execute(
                    $self->{short_desc},
                    $self->{question},
                    $self->{answer},
                    #$self->{file},
                    $self->{par_time},
                    $self->{uuid},
                    $self->{ref},
                    $self->{author},
                );

        unless ($res) {
            carp "Unable to INSERT problem.";
            $dbh->rollback();
            return;
        }

	    $problem_id = $dbh->last_insert_id(undef, undef, "problems", undef);
    }
    # }}}

    # {{{ insert tags
	my @tags = @{$self->{tags}};

    if ($update_else_insert) {
        # Tags are not modified during an update
    } else {

        #my $sel_problem_sql = "SELECT problem_id FROM Problems WHERE uuid = ? ;";


        foreach my $tag (@tags) {

#            my $sel_tag_sql = "SELECT tag_id FROM Tags WHERE tag = ? ;";
#            my $tag_id_ref = $dbh->selectcol_arrayref($sel_tag_sql, {}, $tag);
#
#            if (! defined $tag_id_ref) {
#                carp "Error trying to SELECT from Tags.";
#                $dbh->rollback();
#                return;
#            }
#
#            my $tag_id;
#            if (@$tag_id_ref > 0) {
#                # there is alread a tag
#                $tag_id = $tag_id_ref->[0];
#            } else {
#                # no tag, insert new tag
#                my $ins_tag_sql = "INSERT INTO Tags (tag) VALUES (?);";
#                my $rv = $dbh->do($ins_tag_sql, {}, $tag);
#                unless ($rv) {
#                    carp "Error trying to INSERT to ProblemTags.";
#                    $dbh->rollback();
#                    return;
#                }
#
#	            $tag_id = $dbh->last_insert_id(undef, undef, "tags", undef);
#            }

            # We should now have a valid $tag_id, insert to ProblemTags.

            #my $ins_ptag_sql = "INSERT INTO ProblemTags (problem_id, tag_id) VALUES (?, ?);";
            my $ins_ptag_sql = "INSERT INTO ProblemTags (problem_id, tag) VALUES (?, ?);";
            my $rv = $dbh->do($ins_ptag_sql, {}, $problem_id, $tag);
            unless ($rv) {
                carp "Error trying to INSERT to ProblemTags.";
                $dbh->rollback();
                return;
            }
        }
    }
    # }}}

    # success!
	$dbh->commit();

    return 1;
}
# }}}

# {{{ load_db

=head2 load_db()

Load a problem from the database.

  $qzp = QuizMaker::Problem->load_db($qzm, $problem_id);

The easier and more common way is to load the problem
using the $qzm object.

  $qzp = $qzm->load_db($problem_id);

=cut

sub load_db {
    my $class = shift;
    my $qzm = shift;
    my $problem_id = shift;

    my $dbh = $qzm->{dbh};
    unless ($dbh) {
        carp " This Problem requires a database object to be associated\n".
             " in the parent (QuizMaker) object in order to perform\n".
             " datbase operations.";
        return;
    }

    my $sql = "SELECT (short_desc, file, date_format, par_time, uuid) FROM Problems WHERE problem_id = $problem_id ;";

    my $row = $dbh->selectrow_hashref($sql);
    my $file = $row->{file};

    my $qzp = $qzm->load_file($file);

    return $qzp;
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
