#!/usr/bin/perl

use lib qw(/home/ccs/public_html/new/only/lib);

use strict;
use warnings;

use URI::Escape;
use Path::Class;
use File::MMagic;
use CGI::Cookie;
use CGI::Session;
use HTML::Entities;
use HTML::Template;
use Encode;
use Digest::MD5 qw(md5_hex);

# パスワード（MD5ハッシュを入力してください）
#MD5 ("test") = 098f6bcd4621d373cade4e832627b4f6
my $PASSWORD = "098f6bcd4621d373cade4e832627b4f6";
# 有効期間
my $EXPIRE = "+1h";

my %param = map { /([^=]+)=(.+)/ } split /&/, $ENV{'QUERY_STRING'};

my $request = uri_unescape($param{'file'});
unless (defined($request)) {
	$request = "index.html";
}

my $file = file($request);
unless( -f $file->absolute ) {
	print "Content-type: text/html; charset=windows-1252\n";
	print "Status: 404 Not Found\n\n";
	print "<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">\n";
	print "<html><head>\n";
	print "<title>404 Not Found</title>\n";
	print "</head><body>\n";
	print "<h1>Not Found</h1>\n";
	print "<p>The requested URL ", encode_entities($ENV{'REQUEST_URI'}), " was not found on this server.</p>\n";
	print "</body></html>\n";
	exit;
}

my %cookies = fetch CGI::Cookie;
my $cookie  = $cookies{'session-id'}->value if ( exists $cookies{'session-id'} );
my $sid  = decode( 'utf8', $cookie ) || undef;
my $session = CGI::Session->new(undef, $sid, {Directory=>'./.session'});

my $loginfailed = 0;
if ($ENV{'REQUEST_METHOD'} eq "POST") {
	read(STDIN, my $postdata, $ENV{'CONTENT_LENGTH'});
	my %postparam = map { /([^=]+)=(.+)/ } split /&/, $postdata;
	if ($PASSWORD eq md5_hex($postparam{'password'})) {
		$session->param('login', 1);
	} else {
		$session->param('login', 0);
		$loginfailed = 1;
	}
}

if (defined $sid && $sid eq $session->id && $session->param('login')) {
	$session->expire($EXPIRE);
	my $mm = new File::MMagic;
	my $sidcookie = CGI::Cookie->new(-name => 'session-id', -value => $session->id, -expires => $EXPIRE);
	print "Content-type:$mm->checktype_filename($file->absolute)\n";
	print "Set-Cookie: $sidcookie\n\n";
	my $reader = $file->open('r') or die $!;
	while (my $line = $reader->getline ) {
		print $line;
	}
	$reader->close;
	exit;
}

if (defined $sid && $sid ne $session->id) {
	$session->close;
	$session->delete;
	$session = CGI::Session->new(undef, undef, {Directory=>'./.session'});
}

$session->expire($EXPIRE);
$session->param('login', 0);

my $sidcookie = CGI::Cookie->new(-name => 'session-id', -value => $session->id, -expires => $EXPIRE);
print "Content-type: text/html;\n";
print "Set-Cookie: $sidcookie\n\n";

my $template = <<'TMPL';
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="utf-8">
	<title>Only page</title>
</head>
<body>
	<TMPL_IF NAME="failed">
	<p class="error">wrong password</p>
	</TMPL_IF>
	<p>
		If show this page, you must login.
	</p>
	<form action="<TMPL_VAR NAME="callbackpage">" method="post">
		<p>
		<input type="password" name="password" size="10">
		<input type="submit" value="login">
		</p>
	</form> 
</body>
</html>
TMPL

my $ht = HTML::Template->new(
	scalarref      => \$template,
	default_escape => 'HTML',
);

my %params = (
	failed => $loginfailed,
	callbackpage => encode_entities($ENV{'REQUEST_URI'}),
);
$ht->param(%params);
print $ht->output();

exit;
