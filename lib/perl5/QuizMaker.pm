package QuizMaker;

use strict;
use warnings;
use Carp;

use QuizMaker::Problem;
use QuizMaker::Test;

use vars qw($VERSION);
$VERSION = '0.02';
require 5.6.1;

=head1 NAME

QuizMaker - Perl 5 module for the QuizMaker system

=head1 SYNOPSIS

  # create new test
  $qzm = QuizMaker::Test->load_file($file);

  # get the problmes (QuizMaker::Problem)
  @problems = @{$qzm->{problems}};

  # do stuff with problems

  # See the documentation for QuizMaker::Test and
  # QuizMaker::Problem for more examples.

=head1 VERSION

This document refers to QuizMaker version 0.02.

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

QuizMaker::Test

=cut

1;
