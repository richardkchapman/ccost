#!/usr/bin/perl 

use strict; 
use RRD::Simple (); 

my $rrd = RRD::Simple->new(); 
my $rrdfile=$ARGV[0]; 
my $source=$ARGV[1]; 
my $type=$ARGV[2]; 
chomp($type); 
$rrd->add_source($rrdfile, $source => $type); 
