use strict;
use warnings;
use v5.10;

use File::Basename;
use lib dirname (__FILE__);

use ChooseYourOwnAdventure;
use Text::Wrap;

my $name = Confirm("What is your name?");
#my $name = "Daniel";
my $deeds_done = 0;
my $total_deeds = 1;

Narrate "\n\n$name, it is a dreary day outside, so you have decided to do something to make a difference. Climate change is probably the most difficult problem facing humanity, so you might as well do something about it today, right? Let's find $total_deeds things that will make a difference.\n\n";

ChilisScene();

sub ChilisScene {
    my $we_re_back = shift;

    my $response = MultipleChoice("You are at Chili's, home of the world-famous Baby Back Ribs. And also the Molten Lava Cake. " . ($we_re_back ? "" : "You walk out the front door, tummy full of ribs, fingers sticky with rib sauce. ") . "Which direction do you go?", 
	    "Across the street to a truck stop", 
	    "Next door into an office building", 
	    "Into the grocery store behind Chili's",
	    "Back into Chili's because you're still hungry!",);

    if($response eq "A") {
	TruckStopScene();
    } elsif($response eq "B") {
	OfficeBuildingScene();
    } elsif($response eq "C") {
	GroceryStoreScene();
    } elsif($response eq "D") {
	while(1) {
	    $response = MultipleChoice("Climate change must wait another 30 minutes. We can't solve the greatest challenge facing humanity if we're hungry, now can we? What do you order?", 
		"Baby Back Ribs", 
		"Grilled Chicken", 
		"Molten Lava Cake", 
		"Baby Back Ribs");

	    if($response eq "A" || $response eq "D") {
		last;
	    } else {
		Narrate("Are you sure? Those Baby Back Ribs look awfully tasy.");
	    }
	}
	Narrate("You order Baby Back Ribs. Mmm. Those sure are tasty. Now, onto the business of saving the world!");
	ChilisScene();
    }
}

sub TruckStopScene {
    my $response = MultipleChoice("You walk to the truck stop. What do you do?",
	    "Go inside the convience store",
	    "Talk to the lady standing by the ice machine",
	    "Run in circles. Just because.",
	    "Go back to Chili's");

    if($response eq "A") {
	do {
	$response = MultipleChoice("Options abound. You could have M&Ms, any number of potato chip varities, a smorgasboard of drink options, each with more sugar than the last, or a Twinkie. What do you buy?",
		"a soda",
		"a Twinkie",
		"M&Ms",
		"two Twinkies",
		"happiness",
		"nothing. Let's go",
		);
	    if($response eq "E") {
		Narrate("Um... $name, you can't buy happiness. Especially not in a truck stop convience store.");
	    } elsif($response eq "D") {
		Narrate("*Two*? We're trying to save the world here.");
	    } elsif($response ne "F") {
		Narrate("Really?");
	    }
	} until $response eq "F";
	TruckStopScene();
    } elsif($response eq "B") {
	do {
	    $response = MultipleChoice("You walk up to the lady. She is wearing a red hat. As you approach, the lettering of the hat comes into focus: \"MAGA\". Uh oh -- a Trump supporter. What do you do?",
		    "Run away screaming",
		    "Approach with caution");
	    if($response eq "A" ) {
		Narrate("You run away screaming. Surprised by the loud noise, the lady looks up and sees your crazy butt running away like a weirdo. Concerned, she follows you to make sure you're OK.");
	    }
	} while $response ne "B";
	Narrate("$name: Hello, ma'am. Um. What... <you stammer> what... business do you have with that ice machine?");
	Narrate("MAGA Lady: Oh, nothing. I am actually here for my company. I own a trucking company and we are deciding on which model trucks to buy for the coming year.");
	Narrate("$name: Oh. Well, that's ... actually interesting. What kinds of trucks are you going to buy?");
	Narrate("MAGA Lady: Well, we usually buy Mack trucks, but my friend inside the store tells me we should switch to the new Tesla Semi. I don't know, though. I don't buy all of that climage change hooey.");
	do {
	    $response = MultipleChoice("Aha! Opportunity! How do we convince her?",
		    "Ma'am, the Tesla Semis are actually cheaper than regular diesel trucks. And they can go 500 miles between charges.",
		    "Aren't you concerned about, you know, all the fires and the floods and the hurricanes?",
		    "Hooey? HOOEY? Have you ever heard of AL GORE??",
		    "Run away screaming");
	    if($response eq "B") {
		Narrate("MAGA Lady: Climate change is hooey!");
	    }
	    elsif($response eq "C") {
		Narrate("MAGA Lady: Al Gore is the Devil!");
		Narrate("$name: Um... ok... he's actually a cool guy, but let's move on.");
	    } elsif($response eq "D") {
		TruckStopScene();
	    }
	} while $response ne "A";
	Narrate("MAGA Lady: Well, $name, that's a fair point. I guess we will buy Tesla Semis next year. Thanks for the tip!");
	$deeds_done++;
	DeedReport();

	ChilisScene();

    } elsif($response eq "C") {
	Narrate("Well that was silly. Now you are dizzy. How exactly is running in circles is going to wave the world? Maybe let's try something different next time.");
	TruckStopScene();
    } else {
	ChilisScene(1);
    }

}

sub DeedReport {
    if($deeds_done < $total_deeds) {
	Narrate("Climate change deed accomplished! You have now completed $deeds_done deeds out of $total_deeds for the day.");
    } else {
	Narrate("You are a climate change hero! You have completed all $deeds_done climate change deeds! You are amazing!");
	Narrate("Game Over!");
	exit 0;
    }
}

sub OfficeBuildingScene {
    Narrate("This scene isn't finished yet. Dag nab it");
    ChilisScene();
}

sub GroceryStoreScene {
    Narrate("This scene isn't finished yet. Dag nab it");
    ChilisScene();
}

