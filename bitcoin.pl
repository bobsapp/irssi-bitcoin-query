use strict;
use vars qw($VERSION %IRSSI);

use Irssi;
use JSON;
use LWP::Simple;
use LWP::UserAgent;

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
    my $quote = decode_json( $content );

    if( $quote->{result} eq 'success' ) {
    	my($high,$low,$avg) = map { $quote->{data}->{$_}->{value} } qw(high low avg);
    	Irssi::active_win->command("/say BTCUSD: high:$high low:$low average:$avg");
    	return;
    }
    Irssi::active_win->command("/say Failed to get mtGox data");
}

sub ltc {
    my ($data, $server, $witem) = @_;
    return unless $witem;

    my $ua = LWP::UserAgent->new( 'agent'=>'Mozilla/5.0' ); #Identify as some browser
    my $url = "https://btc-e.com/api/2/ltc_usd/ticker";
    my $res = $ua->get($url);
    my $content = $res->content();
    my $quote = decode_json( $content );

    if( $quote ) {
    	my($high,$low,$avg) = map { $quote->{ticker}->{$_} } qw(high low avg);
    	Irssi::active_win->command("/say LTCUSD: high:$high low:$low average:$avg");
    	return;
    }

    Irssi::active_win->command("/say failed to get BTC-e data");
}

Irssi::command_bind btc => \&btc;
Irssi::command_bind ltc => \&ltc;
