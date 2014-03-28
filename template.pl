#!/usr/bin/perl

use warnings;		# should always use warnings!
use strict;		# should always use strict!
use Getopt::Long;	# to parse command line options
use Pod::Usage;		# to print out help messages

=pod

=head1 NAME

template.pl - basic template for perl scripts

=head1 DESCRIPTION

Short description of script

=head1 SYNOPSIS

scriptname.pl [-vdh] 

=head1 ARGUMENTS

=over

=item --help|h

Prints out help information

=item --verbose|v

Verbose status messages

=item --debug|d

Debug information 

=back

=head1 EXAMPLES

=over

=item scriptname.pl -v

will run the script with verbose messages

=back

=cut

###################################################################### 
# Variables that can be changed from command line options
######################################################################
our $verbose	= 0;	# Controls output verbosity
our $help	= 0;	# If set to 1, help text will be printed
our $debug	= 0;	# If set to 1, debug messages will be printed

######################################################################
# Variables that need to be specified from command line options
######################################################################


######################################################################
# Other variables used in the script
######################################################################


######################################################################
# Functions used in this script
######################################################################
use subs qw(
	     debug
	     get_options
	     logerr
	     logmsg
	     verbose
	  );


# This is where the actual script starts
# First we get the command line options.
get_options();

=head1 Functions in this script

=head2 Main functions

=head3 first_function

Description of first function

=cut

sub first_function {
  # Actual function goes here
  return 1;
}


=head2 Helper functions

=head3 get_options()

Parses command line options

=cut

sub get_options {
  my $result = GetOptions("debug"	=> \$debug,
			  "verbose"	=> \$verbose,
			  "help"	=> \$help,
			  );
  #  If there's an error parsing the command line options, printout a
  # message with the correct syntax and exit
  if (not $result) {
    pod2usage();
  }
  # If the -help option is given, just print out syntax, option and
  # examples and exit
  if ($help) {
    pod2usage(1);
  }
  return 1;
}

=head3 logmsg("string")

Print "string" to STDOUT

=cut

sub logmsg {
  print "@_\n";
  return 1;
}

=head3 verbose("string")

If $verbose is set, "string" will be printed to STDOUT

=cut

sub verbose {
  if ($verbose) {
    print "@_\n";
  }
  return 1;
}

=head3 debug("string")

If $debug is set, "string" will be printed to STDOUT

=cut

sub debug {
  if ($debug) {
    print "@_\n";
  }
  return 1;
}

=head3 logerr("string")

Print "string" to STDERR

=cut

sub logerr {
  print STDERR "ERROR: @_\n";
  return 1;
}


=head1 AUTHOR

Jenny Dybedahl <jenny.dybedahl@init.se>

=head1 LICENSE

BSD 3-Clause "New" or "Revised" license - see
https://github.com/jdybedahl/templates/blob/master/LICENSE 
