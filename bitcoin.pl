use strict;
use vars qw($VERSION %IRSSI);

use Irssi;
$VERSION = '1.00';
%IRSSI = (
    authors     => 'Arnold Judas Rimmer',
    contact     => 'anonymous.of.london.south@gmail.com',
    name        => 'A simple BTC/LTC query script',
    description => 'This script lets you' .
                   'query the current prices' .
                   'Of BTC and LTC.',
    license     => 'Public Domain',
);

sub btc {
    my ($data, $server, $witem) = @_;
    return unless $witem;
    # $witem (window item) may be undef.

    $witem->print('It works!');
}

Irssi::command_bind test => \&testing;
Irssi::command_bind hello => sub {
    print 'Hello, world!';
};