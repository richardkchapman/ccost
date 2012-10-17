#!/usr/bin/perl

# Reads data from a Current Cost device via serial port.

use strict;
use warnings;

use Proc::Daemon;
use Proc::PID::File;
use Device::SerialPort qw( :PARAM :STAT 0.07 );
use File::Copy;

my $PORT = "/dev/ttyUSB0";
my $RRDFILE_SAVE = "/usr/local/var/ccost/powertemp.rrd";
my $RRDFILE = "/tmp/ccost/powertemp.rrd";
my $IMPORTFILE = "/tmp/ccost/current.log";
my $EXPORTFILE = "/tmp/ccost/currentexport.log";
my $APP1FILE = "/tmp/ccost/currentapp1.log";
my $APP4FILE = "/tmp/ccost/currentapp4.log";
my $APP5FILE = "/tmp/ccost/currentapp5.log";
my $APP6FILE = "/tmp/ccost/currentapp6.log";
my $CCT7FILE = "/tmp/ccost/currentcct7.log";
my $CCT8FILE = "/tmp/ccost/currentcct8.log";
my $CCT9FILE = "/tmp/ccost/currentcct9.log";
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
      $PORT = "/dev/$arg"
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
  my $importing = 0;
  my $exporting = 0;
  my $exportSeen = 0;
  my $generating = 0;
  my $generateSeen = 0;
  my $app1 = 0;
  my $app4 = 0;
  my $app5 = 0;
  my $app6 = 0;
  my $cct7 = 0;
  my $cct8 = 0;
  my $cct9 = 0;
  my $temp = 0;
  my $lastSaveTime = time;
  while (my $line = <SERIAL>) {
    my $timeSinceSave = time - $lastSaveTime;
    if ($timeSinceSave > 3600) {
      if ($verbose > 0) {
        print "Saving result file\n";
      }
      copy($RRDFILE, $RRDFILE_SAVE);
      $lastSaveTime = time;
    }
    if ($verbose > 1) {
      print $line;
    }
    if ($line =~ m!<tmpr> *([\-\d.]+)</tmpr>!) {
        $temp = $1;
    }
    if ($line =~ m!<sensor>0</sensor>.*<ch1><watts>0*(\d+)</watts></ch1>!) {
        $importing = $1;
        system("echo $importing >$IMPORTFILE");
        if ($importing > 0) {
           $exporting = 0;
           $exportSeen = 0;
           system("echo $exporting >$EXPORTFILE");
        }
        if ($update && $generateSeen) {
          system("rrdtool", "update", "$RRDFILE", "N:$importing:$temp:$generating:$app1:$exporting:$app4:$app5:$app6:$cct7:$cct8:$cct9");
        }
        if ($verbose) {
          print "N:$importing:$temp:$generating:$app1:$exporting:$app4:$app5:$app6:$cct7:$cct8:$cct9\n";
        }
    }
    elsif ($line =~ m!<sensor>1</sensor>.*<ch1><watts>0*(\d+)</watts></ch1>!) {
        $app1 = $1;
        system("echo $app1 >$APP1FILE");
    }
    elsif ($line =~ m!<sensor>4</sensor>.*<ch1><watts>0*(\d+)</watts></ch1>!) {
        $app4 = $1;
        system("echo $app4 >$APP4FILE");
    }
    elsif ($line =~ m!<sensor>5</sensor>.*<ch1><watts>0*(\d+)</watts></ch1>!) {
        $app5 = $1;
        system("echo $app5 >$APP5FILE");
    }
    elsif ($line =~ m!<sensor>6</sensor>.*<ch1><watts>0*(\d+)</watts></ch1>!) {
        $app6 = $1;
        system("echo $app6 >$APP6FILE");
    }
    elsif ($line =~ m!<sensor>7</sensor>.*<ch1><watts>0*(\d+)</watts></ch1>!) {
        $cct7 = $1;
        system("echo $cct7 >$CCT7FILE");
    }
    elsif ($line =~ m!<sensor>8</sensor>.*<ch1><watts>0*(\d+)</watts></ch1>!) {
        $cct8 = $1;
        system("echo $cct8 >$CCT8FILE");
    }
    elsif ($line =~ m!<sensor>9</sensor>.*<ch1><watts>0*(\d+)</watts></ch1>!) {
        $cct9 = $1;
        system("echo $cct9 >$CCT9FILE");
    }
    elsif ($line =~ m!<sensor>2</sensor>.*<ch1><watts>0*(\d+)</watts></ch1>!) {
        $generating = $1;
        $generateSeen = 1;
        system("echo $generating >$GENERATINGFILE");
    }
    elsif ($line =~ m!<sensor>3</sensor>.*<ch1><watts>0*(\d+)</watts></ch1>!) {
        if ($importing == 0) {
          if ($exportSeen) {
            $exporting = $1;
            system("echo $exporting >$EXPORTFILE");
          } else {
            $exportSeen = 1;
          }
        }
    }
  }

