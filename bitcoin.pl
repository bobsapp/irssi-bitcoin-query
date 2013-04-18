use strict;
use vars qw($VERSION %IRSSI);

use Irssi;
use JSON;
use LWP::Simple;

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
    my $content = get("https://data.mtgox.com/api/2/BTCUSD/money/ticker");
    my $response = $json->decode( $content );

    # $witem->print('It works!');
    if( $response->{result} eq 'success' ) {
    	my($high,$low,$avg) = map { $response->{data}->{$_}->{value} } qw(high low average);
    	Irssi::active_win->command("/say BTCUSD: high:$high low:$low average:$avg");
    	return;
    }
    Irssi::active_win->command("/say Failed to get mtGox data");
}

sub ltc {
    my ($data, $server, $witem) = @_;
    return unless $witem;

    # https://btc-e.com/exchange/ltc_usd

    # $witem->print('It works!');
    Irssi::active_win->command("/say sup dawg dat ltc be blingin");
}

Irssi::command_bind btc => \&btc;
Irssi::command_bind ltc => \&ltc;
