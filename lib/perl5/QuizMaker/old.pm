package QuizMaker::Problem;

use strict;
use warnings;
use Carp;

use vars qw($VERSION);
$VERSION = '0.02';
require 5.6.1;

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
    our ($question, $answer, $short_desc, $par_time, @tags, $worklines, $uuid);

   eval($code);

   bless {
        file => $file,
        question => $question,
        answer => $answer,
        short_desc => $short_desc,
        par_time => $par_time,
        tags => [@tags],
        worklines => $worklines,
        uuid => $uuid,
    }, $class;
}
# }}}

# {{{ to_tex

=head2 $qzm->to_tex();

  $tex = $qzm->to_tex();
  $tex = $qzm->to_tex('answer');
  $tex = $qzm->to_tex('answer', 'preview);

    Returns: string on success, undef otherwise

Convert the problem representation to TeX format suitable for
processing with LaTeX.

=cut

sub to_tex {
    my $self = shift;
    my $answerp = shift;   # display answer? TRUE or FALSE
    my $previewp = shift;  # is this a preview?  TRUE or FALSE

    my $tex;

    if ($previewp) {
        $tex .=
        "\\begin{flushleft}\n".
        "(Preview)\n".
        "\\today\n".
        "\\end{flushleft}\n".
        "\n";
    }

    $tex .= "\\begin{samepage}\n";

    $tex .= "1.)\n";

    $tex .=  $self->{'question'} . "\n";

    $tex .= tex_worklines($self->{'worklines'});

    $tex .= "\\end{samepage}\n";

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

sub tex_worklines {
	my $n = shift;

    # default number of lines
	if (! defined $n) {
		$n = 4
	}

    my $tex;

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

    return $tex;
}
# }}}


# TODO - convert the following code to object oriented style

# {{{ db fns

# {{{ is_valid_test_id ($test_id)
sub is_valid_test_id {
	my ($dbh, $test_id) = @_;

	my $sql =
		"SELECT count(*) FROM Tests WHERE test_id = ? ;";

	my $sth = $dbh->prepare($sql);
	$sth->execute($test_id);
	($sth->fetchrow_array())[0];
}
# }}}

# {{{ get_all_tests_data
# get_all_tests_data
sub get_all_tests_data {
	my ($dbh) = @_;

	my %data;

	my $all_tests_sql =
		"SELECT test_id, finished, dsc FROM Tests;";

	my $all_tests_sth = $dbh->prepare($all_tests_sql);
	$all_tests_sth->execute();

	my $tests_ref = $all_tests_sth->fetchall_arrayref();
	$data{num_tests} = @$tests_ref;

	my $all_test_data_sql = "
		SELECT
		(SELECT count(*) FROM TestProblems WHERE test_id = ?) AS count,

		(SELECT count(*) FROM TestProblemResults WHERE
			correct_p IS TRUE
			AND	test_id = ?) AS num_corr,

		(SELECT sum(end_t - start_t) FROM TestProblemResults WHERE
			test_id = ?) AS act_time,

		(SELECT sum(par_time) AS total_par_t FROM Problems AS P1 WHERE
			P1.problem_id IN
				(SELECT problem_id FROM TestProblems WHERE test_id = ?))
					AS total_par_t ;
	";

	my $all_test_data_sth = $dbh->prepare($all_test_data_sql);

	my $c = 0;
	foreach my $test_ref (@$tests_ref) {
		my $test_id = $test_ref->[0];
		my $finished = $test_ref->[1];

		$data{tests}[$c]{id} = $test_ref->[0];
		$data{tests}[$c]{finished} = $test_ref->[1];
		$data{tests}[$c]{desc} = $test_ref->[2];

		$all_test_data_sth->execute($test_id, $test_id, $test_id, $test_id);

		my $row = $all_test_data_sth->fetchrow_arrayref();

		$data{tests}[$c]{count} = $row->[0];
		$data{tests}[$c]{par_time} = $row->[3];

		if ($finished) {
			$data{tests}[$c]{'time'} = $row->[2];
			$data{tests}[$c]{num_corr} = $row->[1];
			$data{tests}[$c]{score} = ($row->[1] / $row->[0]) * 100;
		} else {
			$data{tests}[$c]{'time'} = undef;
			$data{tests}[$c]{num_corr} = undef;
			$data{tests}[$c]{score} = undef;
		}

		$c++;
	}

	\%data;
}
# }}}

# {{{ get_test_data
sub get_test_data {
	my ($dbh, $test_id) = @_;

	my %data;

	my $all_test_sql =
	"SELECT
    (SELECT count(*) FROM TestProblems
		WHERE test_id = ?)
			AS total,

    (SELECT count(*) FROM TestProblemResults AS TPR
		WHERE test_id = ?
		AND   correct_p IS TRUE
		AND   problem_id IN (SELECT problem_id FROM TestProblems AS TP WHERE
				TP.test_id = TPR.test_id))
					AS num_corr

	";

	my $all_tags_sql = "
	SELECT tag FROM ProblemTags WHERE
		problem_id IN (SELECT problem_id FROM TestProblems WHERE
						test_id = ?) ;
	";


	my $per_tag_data_sql =
	"SELECT
    (SELECT count(*) FROM TestProblems
		WHERE test_id = ?
		AND   problem_id IN (SELECT problem_id FROM ProblemTags WHERE tag = ?))
				AS num_total,

    (SELECT count(*) FROM TestProblemResults AS TPR
		WHERE test_id = ?
		AND   correct_p IS TRUE
		AND   problem_id IN (SELECT problem_id FROM ProblemTags WHERE tag = ?))
				AS num_corr,

    (SELECT sum(end_t - start_t) FROM TestProblemResults AS TPR
		WHERE test_id = ?
		AND   problem_id IN (SELECT problem_id FROM ProblemTags WHERE tag = ?))
				AS act_time,

    (SELECT sum(par_time) FROM Problems AS P1 WHERE
		problem_id IN (SELECT problem_id FROM TestProblems WHERE test_id = ?
			AND problem_id IN (SELECT problem_id FROM ProblemTags WHERE tag = ?)))
				AS par_time
	";


	my $all_test_sth = $dbh->prepare($all_test_sql);
	$all_test_sth->execute($test_id, $test_id);
	my ($total_cnt, $total_num_corr) = $all_test_sth->fetchrow_array();

	$data{count} = $total_cnt;
	$data{num_corr} = $total_num_corr;

	my $all_tags_sth = $dbh->prepare($all_tags_sql);
	$all_tags_sth->execute($test_id);
	my @tags = @{$all_tags_sth->fetchall_arrayref()};
	@tags = map { $_->[0] } @tags;


	my $per_tag_data_sth = $dbh->prepare($per_tag_data_sql);

	foreach my $tag (@tags) {


		$per_tag_data_sth->execute($test_id, $tag, $test_id, $tag, $test_id, $tag, $test_id, $tag);

		my $per_tag_data_ref = $per_tag_data_sth->fetchrow_arrayref();

		$data{tags}{$tag}{tag} = $tag;
		$data{tags}{$tag}{total} = $per_tag_data_ref->[0];
		$data{tags}{$tag}{num_corr} = $per_tag_data_ref->[1];
		$data{tags}{$tag}{act_time} = $per_tag_data_ref->[2];
		$data{tags}{$tag}{par_time} = $per_tag_data_ref->[3];
	}

	\%data;
}
# }}}


# {{{ get_num_qs ($test_id)
sub get_num_qs {
	my ($dbh, $test_id) = @_;

	my $sql =
		"SELECT count(*) FROM TestProblems WHERE test_id = ? ;";

	my $sth = $dbh->prepare($sql);
	$sth->execute($test_id);
	($sth->fetchrow_array())[0];
}
# }}}

# {{{ get_test_desc ($test_id)
sub get_test_desc {
	my ($dbh, $test_id) = @_;

	my $sql =
		"SELECT dsc FROM Tests WHERE test_id = ? ;";

	my $sth = $dbh->prepare($sql);
	$sth->execute($test_id);
	($sth->fetchrow_array())[0];
}
# }}}

# {{{ get_num_qs_done ($test_id)
sub get_num_qs_done{
	my ($dbh, $test_id) = @_;

	my $sql =
		"SELECT count(*) FROM TestProblemResults WHERE test_id = ? ;";

	my $sth = $dbh->prepare($sql);
	$sth->execute($test_id);
	($sth->fetchrow_array())[0];
}
# }}}

# {{{ get_num_correct ($test_id)
sub get_num_correct {
	my ($dbh, $test_id) = @_;

	my $sql =
		"SELECT count(*) FROM TestProblemResults WHERE
			correct_p IS TRUE
			AND	test_id = ? ;";

	my $sth = $dbh->prepare($sql);
	$sth->execute($test_id);
	($sth->fetchrow_array())[0];
}
# }}}

# {{{ get_test_act_time ($test_id)
sub get_test_act_time {
	my ($dbh, $test_id) = @_;

	# XXX Assumes the test is complete.  It is not accurate if the
	#  test is partially finished.

	my $sql =
		"SELECT sum(end_t - start_t) AS total_t FROM TestProblemResults WHERE
			test_id = ? ;";

	my $sth = $dbh->prepare($sql);
	$sth->execute($test_id);
	($sth->fetchrow_array())[0];
}
# }}}

# {{{ get_test_par_time ($test_id)
sub get_test_par_time {
	my ($dbh, $test_id) = @_;

	my $sql =
		"SELECT sum(par_time) AS total_par_t FROM Problems AS P1 WHERE
			P1.problem_id IN
				(SELECT problem_id FROM TestProblems WHERE test_id = ?) ;";

	my $sth = $dbh->prepare($sql);
	$sth->execute($test_id);
	($sth->fetchrow_array())[0];
}
# }}}

# {{{ get_all_tests
# get_all_tests
sub get_all_tests {
	my ($dbh) = @_;

	my $sql =
		"SELECT test_id FROM Tests where finished IS TRUE ;";

	my $sth = $dbh->prepare($sql);
	$sth->execute();
	my $test_ids_ref = $sth->fetchall_arrayref();
	my @test_ids = map { $_->[0] } @$test_ids_ref;

	\@test_ids;
}
# }}}

# {{{ get_all_unfinished_tests
sub get_all_unfinished_tests {
	my ($dbh) = @_;

	my $sql =
		"SELECT test_id FROM Tests where finished IS FALSE ;";

	my $sth = $dbh->prepare($sql);
	$sth->execute();
	my $test_ids_ref = $sth->fetchall_arrayref();
	my @test_ids = map { $_->[0] } @$test_ids_ref;

	\@test_ids;
}
# }}}

# {{{ get_open_tests
# tests which some questions have been done but not all
sub get_open_tests {
	my ($dbh) = @_;

	my @test_ids = @{get_all_tests($dbh)};

	my @open_tests;
	foreach my $test_id (@test_ids) {
		my $num_qs = get_num_qs($dbh);

		my $num_qs_done = get_num_qs_done($dbh, $test_id);

		if ($num_qs_done > 0 and $num_qs > 0 and $num_qs_done % $num_qs != 0) {
			push @open_tests, $test_id;
		} 
	}

	\@open_tests;
}
# }}}

# {{{ print_test_header, print_test

{

our ($test_id, $dsc, $count, $time);
format PRINT_TEST =
@<<<<<<<<  @<<<<<<<<<<<<<<<<...  @<<<<<...  @<<<<<<<<...
$test_id, $dsc, $count, $time
.

sub print_test_header {

	my $ofh = select(STDOUT);
	$~ = "PRINT_TEST";

	$test_id = "test_id";
	$dsc =     "dsc     ";
	$count =   "num qs";
	$time =    "time  ";
	write();
	$test_id =~ s/./-/g;
	$dsc =~ s/./-/g;
	$count =~ s/./-/g;
	$time =~ s/./-/g;
	write;

	select($ofh);
}

sub print_test {
	my $dbh = $_[0];
	$test_id = $_[1];

	my $ofh = select(STDOUT);
	$~ = "PRINT_TEST";


	$dsc = get_test_desc($dbh, $test_id);
	$count = get_num_qs($dbh, $test_id);
	$time = get_test_par_time($dbh, $test_id);

	write;

	select($ofh);
}

}
# }}}

# {{{ get_start_time
#	$test_start_time = get_start_time($dbh, $test_id);

sub get_start_time {
	my ($dbh, $test_id) = @_;

	my ($test_start_time, $test_problems_cnt, $test_problem_results_cnt);

	my $sql1 = "SELECT max(test_start_time) FROM TestProblemResults WHERE
				test_id = ? ;";
	my $sth1 = $dbh->prepare($sql1);
	$sth1->execute($test_id);
	$test_start_time = ($sth1->fetchrow_array)[0];

	if (! $test_start_time) {
		$test_problems_cnt = 0;
		$test_problem_results_cnt = 0;
	} else {
		my $sql2 =
			"SELECT count(*) FROM TestProblemResults WHERE
				test_start_time = ?
				AND test_id = ? ;";
		my $sth2 = $dbh->prepare($sql2);
		$sth2->execute($test_start_time, $test_id);
		$test_problem_results_cnt = ($sth2->fetchrow_array())[0];

		my $sql3 =
			"SELECT count(*) FROM TestProblems WHERE
				test_id = ? ";
		my $sth3 = $dbh->prepare($sql3);
		$sth3->execute($test_id);
		$test_problems_cnt = ($sth3->fetchrow_array())[0];
	}


	if ($test_problems_cnt == $test_problem_results_cnt) {
		# create a new time
		my $sql4 = "SELECT CURRENT_TIMESTAMP ;";
		$test_start_time = $dbh->selectrow_array($sql4);
	} else {
		#$test_start_time; already set
	}

	$test_start_time;
}
# }}}

# {{{ next_problem

sub next_problem {
	my ($dbh, $test_id, $test_start_time) = @_;

	my $sql1 =
		"SELECT problem_id, problem_num FROM TestProblems
			WHERE test_id = ?
			AND problem_id NOT IN
				(SELECT problem_id FROM TestProblemResults
					WHERE test_id = TestProblems.test_id
					AND test_start_time = ?
					AND end_t IS NOT NULL)
			ORDER BY problem_num LIMIT 1 ;";
	# if undef, no more questions
	my $sth2 = $dbh->prepare($sql1);
	$sth2->execute($test_id, $test_start_time);
	my ($problem_id, $problem_num) = $sth2->fetchrow_array();
		
	if (! $problem_id) {
		return undef;
	}

	my $sql2 =
		"INSERT INTO TestProblemResults (test_start_time, start_t,
				test_id, problem_id)
			VALUES (?, CURRENT_TIMESTAMP, ?, ?) ;";
	$dbh->do($sql2, undef, $test_start_time, $test_id, $problem_id);

	($problem_id, $problem_num);
}
# }}}

# {{{ stop_problem

sub stop_problem {
	my ($dbh, $test_id, $test_start_time, $problem_id) = @_;

	my $sql1 =
		"UPDATE TestProblemResults SET end_t = CURRENT_TIMESTAMP
			WHERE test_id = ?
			AND   test_start_time = ?
			AND   problem_id = ? ;";
	$dbh->do($sql1, undef, $test_id, $test_start_time, $problem_id);
}
# }}}

# }}}


1;
