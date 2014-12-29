#!/usr/bin/perl

use lib qw(/home/ccs/public_html/new/only/lib);

use strict;
use warnings;

use CGI;
use Digest::MD5 qw(md5_hex);

my $SALT = '}_Y=cIaDV}J,kzZ@a4EA*bK~svx(.QyD';

my $query = new CGI;
my $passwd = $query->param('passwd');

print "Content-type:text/plain\n\n";
print md5_hex($passwd.$SALT), "\n";

