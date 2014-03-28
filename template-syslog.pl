#!/usr/bin/perl

use warnings;		# should always use warnings!
use strict;		# should always use strict!
use Getopt::Long;	# to parse command line options
use Pod::Usage;		# to print out help messages
use Sys::Syslog;	# for logging

=pod

=head1 NAME

template-syslog.pl - basic template, using syslog instead of STDOUT/STDERR

=head1 DESCRIPTION

Short description of script

=head1 SYNOPSIS

scriptname.pl [-vdh] [-f facility]

=head1 ARGUMENTS

=over

=item --help|h

Prints out help information

=item --verbose|v

Verbose status messages

=item --debug|d

Debug information 

=item --facility|f

Log facility for syslog messages. Defaults to local3.

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
our $facility	= "local3";

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
	     dolog
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
			  "facility=s"	=> \$facility,
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

log "string" to syslog, facility $facility, loglevel info

=cut

sub logmsg {
    dolog({ loglevel	=> "info",
	    string	=> "@_"
	  });
}


=head3 logerr("string")

log "string" to syslog, facility $facility, loglevel error

=cut

sub logerr {
    dolog({ loglevel	=> "error",
	    string	=> "@_"
	  });
    return 1;
}

=head3 dolog({loglevel => "loglevel",
	      string   => "string")

write "string" to syslog with facility $facility and loglevel "loglevel"

=cut

sub dolog {
    my $arg_href = shift;
    my $loglevel = $arg_href->{loglevel};
    my $string	 = $arg_href->{string};
    openlog "$scriptname ", 'cons,pid' , $facility;
    syslog($loglevel, "$string");
    closelog;
    return 1;
}

=head1 AUTHOR

Jenny Dybedahl <jenny.dybedahl@init.se>

=head1 LICENSE

BSD 3-Clause "New" or "Revised" license - see
https://github.com/jdybedahl/templates/blob/master/LICENSE for further
informationfor license
