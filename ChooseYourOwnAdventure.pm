use strict;
use warnings;
use v5.10;

package ChooseYourOwnAdventure;
use Term::ReadKey;
use Text::Wrap;
use Time::HiRes qw/usleep/;

use Exporter;
our @ISA = qw/Exporter/;
our @EXPORT = qw/Confirm Validate MultipleChoice Narrate/;

sub Confirm {
    my $message = shift;

    my ($response,$confirm);
    do {
        print wrap("", "", $message . " ");

        $response = <STDIN>;
        chomp $response;
        print "You typed \"$response\". Is that correct? (y/n) ";

        ReadMode('cbreak');
        $confirm = ReadKey(0);
        ReadMode('normal');
        print "\n";
    } while(lc($confirm) ne 'y');
    return $response;
}

sub Validate {
    my $message = shift;
    my @valid_responses = @_;

    my $single_letter = AllResponsesAreASingleCharacter(@valid_responses);

    my %valid_r_hash = map { lc($_) => 1 } @valid_responses;
    my $response;
    while(1) {
        print wrap("", "", $message . " ") if $message;

        if($single_letter) {
            ReadMode('cbreak');
            $response = ReadKey(0);
            ReadMode('normal');
            print "$response\n\n";
            usleep 200000;
        } else {
            $response = <STDIN>;
            chomp $response;
        }

        if(!defined $valid_r_hash{lc($response)}) {
            say wrap("", "", "Invalid response \"$response.\"  Valid responses are: " 
                    . join(", ", @valid_responses));
        } else {
            # Make case match the valid_responses
            foreach my $vr (@valid_responses) {
                if(lc($vr) eq lc($response)) {
                    $response = $vr;
                    last;
                }
            }
            last;
        }

    } 
    return $response;
}

sub AllResponsesAreASingleCharacter {
    foreach my $r (@_) {
        return 0 if length($r) > 1;
    }
    return 1;
}

sub Narrate {
    my $message = shift;
    say wrap("", "", $message . "\n");
    usleep 500000;
}

sub MultipleChoice {
    my $message = shift;
    my @choices = @_;
    say wrap("", "", $message);
    my $choice_iterator = 0;
    print map {  wrap("\t", "\t   ", chr(65 + $choice_iterator++) . ") $_\n") } @choices;

    $choice_iterator = 0;
    my @valid_responses = map { chr(65 + $choice_iterator++) } @choices;

    return Validate("Your response:", @valid_responses);
}

