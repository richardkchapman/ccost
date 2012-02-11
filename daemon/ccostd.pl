#!/usr/bin/perl

# Reads data from a Current Cost device via serial port.

use strict;
use warnings;

use Proc::Daemon;
use Proc::PID::File;
use Device::SerialPort qw( :PARAM :STAT 0.07 );
use File::Copy;

my $PORT = "/dev/ttyUSB1";
my $RRDFILE_SAVE = "/usr/local/var/ccost/powertemp.rrd";
my $RRDFILE = "/tmp/ccost/powertemp.rrd";
my $CURRENTFILE = "/tmp/ccost/current.log";
my $APP1FILE = "/tmp/ccost/currentapp1.log";
my $GENERATINGFILE = "/tmp/ccost/currentgenerating.log";

MAIN:
  my $verbose = 0;
  my $update = 1;
  my $daemon = 1;
  while ( my $arg = shift @ARGV ) {
    if ( $arg eq '-v' ) {
      $verbose = $verbose + 1;
      $daemon = 0;
    } elsif ( $arg eq '-u' ) {
      $update = 0;
      $daemon = 0;
    } else {
#      usage();
      exit 1;
    }
  }
  if ($daemon) {
    # Daemonize
    Proc::Daemon::Init();
    # If already running, then exit
    if (Proc::PID::File->running()) {
       exit(0);
    }
  }
  mkdir "/tmp/ccost";
  mkdir "/tmp/ccost/png";
  system("chown -R http:http /tmp/ccost/png");
  copy($RRDFILE_SAVE, $RRDFILE) unless -e $RRDFILE;
  my $ob = Device::SerialPort->new($PORT);
  $ob->baudrate(57600);
  $ob->write_settings;

  open(SERIAL, "+>$PORT");
  my $watts = 0;
  my $generating = 0;
  my $app1 = 0;
  my $temp = 0;
  while (my $line = <SERIAL>) {
    if ($verbose > 1) {
      print $line;
    }
    if ($line =~ m!<tmpr> *([\-\d.]+)</tmpr>!) {
        $temp = $1;
    }
    if ($line =~ m!<sensor>0</sensor>.*<ch1><watts>0*(\d+)</watts></ch1>!) {
        $watts = $1;
        system("echo $watts >$CURRENTFILE");
    }
    if ($line =~ m!<sensor>1</sensor>.*<ch1><watts>0*(\d+)</watts></ch1>!) {
        $app1 = $1;
        system("echo $app1 >$APP1FILE");
    }
    if ($line =~ m!<sensor>2</sensor>.*<ch1><watts>0*(\d+)</watts></ch1>!) {
        $generating = $1;
        system("echo $generating >$GENERATINGFILE");
    }
    if ($update) {
      system("rrdtool", "update", "$RRDFILE", "N:$watts:$temp:$generating:$app1");
    }
    if ($verbose) {
      print "N:$watts:$temp:$generating:$app1\n";
    }
  }

