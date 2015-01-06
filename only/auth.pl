#!/usr/bin/perl

use strict;
use warnings;

use CGI;
use JSON::PP;
use Digest::SHA;

my $PASSWORD = '36346c1532c5579654456183c1b2a95ac4e499e881b91e6c654686ab27fb1942da1aa4e7a1fceced2291e0c476d01e86c233c1aa3410ff72addf652289e1da45';
my $SALT = '}_Y=cIaDV}J,kzZ@a4EA*bK~svx(.QyD';

my $sha = Digest::SHA->new(512);

my $query = new CGI;
my $passwd = $query->param('passwd');
my $hash = $sha->add($passwd.$SALT)->hexdigest;

my %res;
$res{'hash'} = $hash;
$res{'ok'} = $PASSWORD eq $hash ? 1 : 0;

print "Content-type:text/plain\n\n";
my $json = encode_json \%res;
print $json, "\n";

