#! /usr/local/perl -w
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

use Test::More qw/no_plan/;

BEGIN {
    use_ok("version", 0.77, qw/qv declare UNIVERSAL::VERSION/);
    # If we made it this far, we are ok.
}

SKIP: {
    skip 'Cannot test with 5.10.0 yet', 518
    	if $] == 5.010_000;
    my $Verbose;
    require "t/coretests.pm";

    diag "Tests with base class" if $Verbose;

    BaseTests("version","new","qv");
    BaseTests("version","new","declare");
    BaseTests("version","parse", "qv");
    BaseTests("version","parse", "declare");

# dummy up a redundant call to satify David Wheeler
    local $SIG{__WARN__} = sub { die $_[0] };
    eval 'use version;';
    unlike ($@, qr/^Subroutine main::declare redefined/,
	"Only export declare once per package (to prevent redefined warnings)."); 
}
