package NetHack::Engravings;
BEGIN {
  $NetHack::Engravings::AUTHORITY = 'cpan:DOY';
}
{
  $NetHack::Engravings::VERSION = '0.02';
}
use strict;
use warnings;
# ABSTRACT: functions related to NetHack engravings

use Exporter 'import';
our @EXPORT_OK = ('is_degradation', 'is_maybe_preengraved');


my %rubouts = (
    '0' => ['(', 'C'],
    '1' => ['|'],
    '6' => ['c', 'o'],
    '7' => ['/'],
    '8' => ['3', 'c', 'o'],
    ':' => ['.'],
    ';' => [','],
    'A' => ['^'],
    'B' => ['-', 'F', 'P', '[', 'b', '|'],
    'b' => ['|'],
    'C' => ['('],
    'D' => [')', '[', '|'],
    'd' => ['c', '|'],
    'E' => ['-', 'F', 'L', '[', '_', '|'],
    'e' => ['c'],
    'F' => ['-', '|'],
    'G' => ['(', 'C'],
    'g' => ['c'],
    'H' => ['-', '|'],
    'h' => ['n', 'r'],
    'I' => ['|'],
    'j' => ['i'],
    'K' => ['<', '|'],
    'k' => ['|'],
    'L' => ['_', '|'],
    'l' => ['|'],
    'M' => ['|'],
    'm' => ['n', 'r'],
    'N' => ['\\', '|'],
    'n' => ['r'],
    'O' => ['(', 'C'],
    'o' => ['c'],
    'P' => ['-', 'F', '|'],
    'Q' => ['(', 'C'],
    'q' => ['c'],
    'R' => ['-', 'F', 'P', '|'],
    'T' => ['|'],
    'U' => ['J'],
    'V' => ['/', '\\'],
    'W' => ['/', 'V', '\\'],
    'w' => ['v'],
    'y' => ['v'],
    'Z' => ['/'],
);


sub is_degradation {
    my ($orig, $cur) = @_;

    my @orig = split '', $orig;
    my @cur  = split '', $cur;

    C: for my $c (@cur) {
        while (@orig) {
            my $o = shift @orig;

            next C if $o eq $c;

            if ($o eq ' ') {
                next C if $c eq ' ';
            }
            else {
                next C if grep { $_ eq $c } @{ $rubouts{$o} || [] }, '?', ' ';
            }
        }

        # we ran out of characters in the original engraving
        return 0 if !@orig;
    }

    return 1;
}

my @preengravings = grep { length && !/^#/ } <DATA>;


sub is_maybe_preengraved {
    my ($engraving) = @_;

    return !!grep { is_degradation($_, $engraving) } @preengravings;
}


1;

=pod

=head1 NAME

NetHack::Engravings - functions related to NetHack engravings

=head1 VERSION

version 0.02

=head1 SYNOPSIS

  use NetHack::Engravings 'is_degradation';

  is_degradation('Elbereth', 'F| ???'); # true

=head1 DESCRIPTION

This module implements some useful functions related to various aspects of
engravings in NetHack. Currently, it only includes a predicate for checking
whether an engraving can be worn away into another engraving, but more
suggestions are welcome.

=head1 FUNCTIONS

=head2 is_degradation($orig, $cur)

Returns true if C<$orig> could possibly degrade to C<$cur>.

=head2 is_maybe_preengraved($engraving)

Returns true if an engraving may have been created during level generation.
This can be used to detect bones levels by finding engravings left by the
previous player (which will likely make this function return false).

=head1 BUGS

No known bugs.

Please report any bugs through RT: email
C<bug-nethack-engravings at rt.cpan.org>, or browse to
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=NetHack-Engravings>.

=head1 SUPPORT

You can find this documentation for this module with the perldoc command.

    perldoc NetHack::Engravings

You can also look for information at:

=over 4

=item * MetaCPAN

L<https://metacpan.org/release/NetHack-Engravings>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=NetHack-Engravings>

=item * Github

L<https://github.com/doy/nethack-engravings>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/NetHack-Engravings>

=back

=head1 AUTHORS

=over 4

=item *

Jesse Luehrs <doy at cpan dot org>

=item *

Shawn M Moore <code@sartak.org>

=back

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Jesse Luehrs.

This is free software, licensed under:

  The NetHack General Public License

=cut

__DATA__
# Hardcoded engravings (random_mesg)
Elbereth
Vlad was here
ad aerarium
Owlbreath
Galadriel
Kilroy was here
A.S. ->
<- A.S.
You won't get it up the steps
Lasciate ogni speranza o voi ch'entrate.
Well Come
We apologize for the inconvenience.
See you next Wednesday
notary sojak
For a good time call 867-5309
Please don't feed the animals.
Madam, in Eden, I'm Adam.
Two thumbs up!
Hello, World!
You've got mail!
As if!

# rumors.tru
A blindfold can be very useful if you're telepathic.
A candelabrum affixed with seven candles shows the way with a magical light.
A crystal plate mail will not rust.
A katana might slice a worm in two.
A magic vomit pump could be useful for gourmands.
A nymph knows how to unlock chains.
A potion of blindness lets you see invisible things.
A priest can get the gods to listen easily.
A priestess and a virgin you might be, but that unicorn won't care.
A ring of conflict is a bad thing if there is a nurse in the room.
A short sword is not as good as a long sword.
A succubus will go farther than a nymph.
A wand can exorcize a past explorer's ghost.
Acid blobs should be attacked bare-handed.
Affairs with nymphs are often very expensive.
Afraid of nymphs?  Wear a ring of adornment.
Afraid of your valuables being stolen?  Carry more junk!
Always be aware of the phase of the moon!
Always sweep the floor before engraving important messages.
Amulets of Yendor are hard to make.  Even for a wand of wishing.
An elven cloak protects against magic.
An umber hulk can be a confusing sight.
As Crom is my witness, I'll never go hungry again!
Asking about monsters may be very useful.
Attack long worms from the rear -- that is so much safer!
Attacking an eel where there is none is usually a fatal mistake!
Bandaging wounds helps keep up appearances.
Bashing monsters with a bow is not such a good idea.
Be careful!  The Wizard may plan an ambush!
Be nice to a nurse:  Put away your weapon and take off your clothes.
Being digested is a painfully slow process.
Blank scrolls make more interesting reading.
Blind?  Catch a floating eye!
Booksellers never read scrolls; they might get carried away.
Chemistry 101: Never pour water into acid.
Concise conquest:  Control, confuse, conjure, condemn.
Conserve energy, turn off the lights.
Digging up a grave could be a bad idea...
Dilithium crystals are rare indeed.
Dogs are attracted by the smell of tripe.
Dogs are superstitious; they never step on cursed items.
Dogs of ghosts aren't angry, just hungry.
Don't forget!  Large dogs are MUCH harder to kill than little dogs.
Don't mess with shopkeepers, or you'll get the Guild after you.
Dragons never whip their children; they wouldn't feel it!
Eat your carrots.  They're good for your eyes.
Eating a freezing sphere is like eating a yeti.
Eating a killer bee is like eating a scorpion.
Eating a tengu is like eating a nymph.
Eating a wraith is a rewarding experience!
Eating unpaid leprechauns may be advantageous.
Elbereth has quite a reputation around these parts.
Elf corpses are incompatible with the sandman, and at times the gods as well.
Elven cloaks cannot rust.
Even evil players have a guardian angel.
Ever fought with an enchanted tooth?
Ever tried reading while confused?
Ever tried to put a troll into a large box?
Ever wondered why one would want to dip something in a potion?
Expensive cameras have penetrating flash lights.
Extra staircases lead to extra levels.
Fiery letters might deter monsters.
For a good time engrave `Elbereth'.
Gems are too precious to be thrown away carelessly.
Getting hungry?  Stop wearing rings!
Getting too warm?  Take off that Amulet of Yendor and stay away from the exit!
Gods expect the best from their priesthood.
Gods look down their noses at demigods.
Got a question?  Try rec.games.roguelike.nethack.
Grave robbers sometimes get rich.
Guy Montag keeps his scrolls in a bag.
Handle your flasks carefully -- there might be a ghost inside!
Holy water has many uses.
Horses trust their riders, even when not so deserved.
Hunger is a confusing experience for a dog!
I once knew a hacker who ate too fast and choked to death.
I smell a maze of twisty little passages.
I wish I never wished a wand of wishing.  (Wishful thinking.)
I wouldn't advise playing catch with a giant.
I'm watching you.  -- The Wizard of Yendor
Ice boxes keep your food fresh.
If you are being punished, it's done with a deadly weapon.
If you kill the Wizard, you get promoted to demi-god.
If you need a wand of digging, kindly ask the minotaur.
If you want to hit, use a dagger.
If you want to rob a shop, train your dog.
If you're lost, try buying a map next time you're in a shop.
Inside a shop you better take a look at the price tags before buying anything.
It is bad manners to use a wand in a shop.
It is dangerous to visit a graveyard at midnight.
It is not always a good idea to whistle for your dog.
It is rumored that the Wizard has hired some help.
It is the letter 'c' and not 'e' that changes status to statue.
It might be a good idea to offer the unicorn a ruby.
It would be peculiarly sad were your dog turned to stone.
It's a `d' eats `d' world.
Keep your armors away from rust.
Keep your weaponry away from acids.
Kill a unicorn of your color and you kill your luck.
Leather is waterproof.  Ever see a cow with an umbrella?
Leprechauns are the most skilled cutpurses in this dungeon.
Lizard corpses protect against cockatrices.
Money lost, little lost; honor lost, much lost; pluck lost, all lost.
Most monsters can't swim.
Music hath charms to affect the stubborn drawbridge.
Music hath charms to soothe the savage beast.
Never attack a guard.
Never ride a long worm.
Never use your best weapon to engrave a curse.
No easy fighting with a heavy load!
Nurses are trained to touch naked persons:  they don't harm them.
Nymphs can unlink more than your chain mail.
Once your little dog will be a big dog, and you will be proud of it.
Only female monsters can lay eggs.
Opening a tin is difficult, especially when you attempt it bare handed!
Orcs and killer bees share their lifestyle.
Orcs do not procreate in dark rooms.
Plain nymphs are harmless.
Playing AD&D may be helpful.
Playing Gauntlet might be enlightening in some situations.
Playing billiards pays when you are in a shop.
Polymorphing a shopkeeper might make you safer.
Polymorphing your dog probably makes you safer.
Potions don't usually mix, but sometimes...
Psst!  It's done with mirrors!
Put on a ring of teleportation:  it will take you away from onslaught.
Rays aren't boomerangs, of course, but still...
Read the manual before entering the cave -- you might get killed otherwise.
Reading Herbert might be enlightening in one case.
Reading Tolkien might help you.
Reading scrolls after drinking booze can give confusing results.
Riding a dragon can be an uplifting experience.
Rust monsters love water.  There are potions they hate, however.
Sacks protect contents from temperatures up to 452 degrees fahrenheit.
Scrolls fading?  It's not the heat, it's the humidity.
Shopkeepers accept credit cards, as long as you pay cash.
Shopkeepers can spot a tourist a mile away with those Hawaiian shirts.
Shopkeepers can't tell identical twins apart.
Shopkeepers don't read, so what use is engraving in a shop?
Shopkeepers have incredible patience.
Shopkeepers might raise their prices for tourists.
Shopkeepers value money more than revenge.
Some monsters can be tamed.  I once saw a hacker with a tame dragon!
Someone once said that what goes up < might come down >.
Someone's been spiking the pits!
Sometimes monsters are more likely to fight each other than attack you.
Spinach, carrot, and jelly -- a meal fit for a nurse!
Tainted meat is even more sickening than poison!
Telepathy is just a trick:  once you know how to do it, it's easy.
The Leprechaun Gold Tru$t is no division of the Magic Memory Vault.
The Wizard finds death to be quite an experience.
The best equipment for your work is, of course, the most expensive.
The gods don't appreciate pesky priesthood.
The gods will get angry if you kill your dog.
The magic marker is mightier than the sword.
The moon is not the only heavenly body to influence this game.
The orc swings his orcish broadsword named Elfrist at you.  You die...
The secret of wands of Nothing Happens:  try again!
There has always been something mystical about mirrors.
There is a Mastermind deep in the dungeon.
There is a big treasure hidden in the zoo!
There is more magic in this cave than meets the eye.
There is no harm in praising a large dog.
There is nothing like eating a mimic.
There once was a Knight named Lancelot who liked to ride with his lance a lot.
They say a gelatinous cube can paralyze you...
They say that Juiblex is afraid of a wand of digging.
They say that Medusa would like to put you on a pedestal.
They say that Vlad lives!!! ... in the mazes.
They say that `Elbereth' is often written about.
They say that a bag of holding can't hold everything.
They say that a blessed tin of quasit meat is a quick meal.
They say that a cat avoids traps.
They say that a cave spider will occasionally eat cave spider eggs.
They say that a clever wizard can have stats:  18/** 24 18 24 24 24.
They say that a clove of garlic makes a good talisman if handled right.
They say that a cursed scroll of teleportation could land you in trouble.
They say that a diamond is another kind of luck stone.
They say that a dog can be trained to fetch objects.
They say that a gelatinous cube makes a healthy breakfast.
They say that a giant gets strong by eating right, try it!
They say that a grid bug won't hit you when you cross it.
They say that a lembas wafer is a very light snack.
They say that a loadstone has a strange attraction and is not bad luck.
They say that a lock pick by any other name is still a lock pick.
They say that a lucky amulet will block poisoned arrows.
They say that a mirror will freeze a floating eye but you can still see it.
They say that a neutral character might get Giantslayer.
They say that a polymorph trap is magic and magic protection prevents it.
They say that a potion of healing can cancel a potion of sickness.
They say that a potion of monster detection sometimes works both ways.
They say that a sink looks different from high above the floor.
They say that a summoned demon could improve your game.
They say that a tin of wraith meat is a rare dining experience.
They say that a unicorn might bring you luck.
They say that a wand of cancellation is like a wand of polymorph.
They say that a wand of locking can close more than just doors.
They say that a wand of polymorph can change your game.
They say that a wizard is even more powerful the second time around.
They say that a xorn knows of no obstacles when pursuing you.
They say that abusing a credit card could shock you sooner or later.
They say that amulets, like most things, can be deadly or life saving.
They say that an altar can identify blessings.
They say that an ooze will bite your boots and a rockmole will eat them.
They say that an unlucky hacker was once killed by an exploding tin.
They say that antique dealers are always interested in precious stones.
They say that bandaging one's wounds helps to keep up one's appearance.
They say that booze can be diluted but not cancelled.
They say that by listening carefully, you can hear a secret door!
They say that carrots and carrot juice may improve your vision.
They say that cave spiders are not considered expensive health food.
They say that demigods must leave behind their prized earthly possessions.
They say that disturbing a djinni can be a costly mistake.
They say that dragon scales can be quite enchanting.
They say that dropping coins into a fountain will not grant you a wish.
They say that dwarves lawfully mind their own business.
They say that eating a bat corpse will make you batty, for a while.
They say that eating a cram ration is a smart move.
They say that eating blue jelly is cool if you don't fight the feeling.
They say that escaping a dungeon is only the beginning of the end.
They say that feeling an unexpected draft of air is sort of a breakthrough.
They say that finding a cursed gray stone is always bad luck.
They say that gaining a level is an experience that can raise your sights.
They say that garter snake meat rarely tastes good but it's still healthy.
They say that gauntlets of dexterity have a hidden enchanted touch.
They say that going to heaven is just another way of escaping the dungeon.
They say that golden nagas are law-abiding denizens as long as you are too.
They say that gremlins can make you feel cooler than you are now.
They say that grid bugs only exist in a strictly Cartesian sense.
They say that hackers often feel jumpy about eating nymphs.
They say that having polymorph control won't shock you.
They say that if it's hard getting your food down another bite could kill.
They say that if you don't wear glasses why bother with carrots?
They say that if you notice a loose board beneath you, don't step on it.
They say that if you start at the bottom the only place to go is up.
They say that if you teleport to heaven you're presumed to be dead already.
They say that in a shop you can be charged for old charges.
They say that in lighter moments you could think of ways to pass a stone.
They say that in the dungeon breaking a mirror can be seven years bad luck.
They say that in the dungeon you don't usually have any luck at all.
They say that in time a blessed luckstone can make your god happy.
They say that it is easier to kill the Wizard than to make him stand still.
They say that it only takes 1 zorkmid to meet the Kops.
They say that it's a blast when you mix the right potions together.
They say that it's not blind luck if you catch a glimpse of Medusa.
They say that killing a shopkeeper brings bad luck.
They say that monsters never step on a scare monster scroll.
They say that most monsters find flute recitals extremely boring.
They say that mummy corpses are not well preserved.
They say that naturally a wand of wishing would be heavily guarded.
They say that no one notices the junk underneath a boulder.
They say that nobody expects a unicorn horn to rust.
They say that nobody knows if an explorer can live forever.  Do you?
They say that nothing can change the fact that some potions contain a djinni.
They say that nothing can change the fact that some potions contain a ghost.
They say that nymphs always fall for rock'n'roll, try it!
They say that once an Olog-Hai is canned it never shows its face again.
They say that once upon a time xans would never scratch your boots.
They say that only an experienced wizard can do the tengu shuffle.
They say that only chaotics can kill shopkeepers and get away with it.
They say that only female monsters can lay eggs.
They say that playing a horn really bad is really good.
They say that rubbing a glowing potion does not make it a magic lamp.
They say that scalpels become dull because they're not athames.
They say that shopkeepers don't like pick-axes.
They say that shopkeepers don't mind you bringing your pets in the shop.
They say that shopkeepers don't usually mind if you sneak into a shop.
They say that shopkeepers often have a large amount of money in their purses.
They say that shopkeepers often remember things that you might forget.
They say that sinks and armor don't mix, take your cloak off now!
They say that sinks run hot and cold and many flavors in between.
They say that snake charmers aren't charismatic, just musical.
They say that soldiers are always prepared and usually protected.
They say that some eggs could hatch in your pack, lucky or not.
They say that some fire ants will make you a hot meal.
They say that some horns play hot music and others are too cool for words.
They say that some humanoids are nonetheless quite human.
They say that some shopkeepers consider gems to be family heirlooms.
They say that some shopkeepers recognize gems but they won't tell you.
They say that some stones are much much heavier than others.
They say that some yetis are full of hot air.
They say that something very special would be in a well-protected place.
They say that speed boots aren't fast enough to let you walk on water.
They say that teleport traps are the devil's work.
They say that tengu don't wear rings, why should you?
They say that tengu never steal gold although they would be good at it.
They say that that which was stolen once can be stolen again, ask any nymph.
They say that the Delphic Oracle knows that lizard corpses aren't confusing.
They say that the Hand of Elbereth can hold up your prayers.
They say that the Leprechaun King is rich as Croesus.
They say that the Wizard of Yendor is schizophrenic and suicidal.
They say that the experienced character knows how to convert an altar.
They say that the gods are happy when they drop objects at your feet.
They say that the idea of invisible Nazguls has a certain ring to it.
They say that the lady of the lake now lives in a fountain somewhere.
They say that the local shopkeeper frowns upon the rude tourist.
They say that the only door to the vampire's tower is on its lowest level.
They say that the only good djinni is a grateful djinni.
They say that the thing about genocide is that it works both ways.
They say that the unicorn horn rule is if it ain't broke then don't fix it.
They say that the view from a fog cloud is really very moving.
They say that the walls in shops are made of extra hard material.
They say that there are at least 15 ways to lose a pair of levitation boots.
They say that throwing glass gems is the same as throwing rocks.
They say that trespassing a boulder is probably beneath you.
They say that unicorns are fond of precious gems.
They say that prayer at an altar can sometimes make the water there holy.
They say that what goes down the drain might come back up.
They say that wielded, a long sword named Fire Brand makes you feel cooler.
They say that wielded, a long sword named Frost Brand makes you hot stuff.
They say that wiping its face is impossible for a floating eye.
They say that with a floating eye you could see in the dark.
They say that you are lucky if you can get a unicorn to catch a ruby.
They say that you are what you eat.
They say that you can find named weapons at an altar if you're lucky.
They say that you can safely touch cockatrice eggs but why bother?
They say that you can't break an amulet of reflection.
They say that you don't always get what you wish for.
They say that you should always be prepared for a final challenge.
They say that you should ask a dwarf to let you into a locked shop.
They say that you should pray for divine inspiration.
They say that you should religiously give your gold away.
They say that you will never get healthy by eating geckos.
They say that zapping yourself with a wand of undead turning is stupid.
They say the Wizard's castle is booby-trapped!
They say the gods get angry if you kill your dog.
They say the gods get angry if you pray too much.
They say there is a powerful magic item hidden in a castle deep down!
Those who wield a cockatrice corpse have a rocky road ahead of them.
Throwing food at a wild dog might tame him.
To a full belly all food is bad.
Trolls are described as rubbery:  they keep bouncing back.
Try the fall-back end-run play against ghosts.
Try using your magic marker on wet scrolls.
Two wrongs don't make a right, but three lefts do.
Valkyries come from the north, and have commensurate abilities.
Vampires hate garlic.
Vault guards never disturb their Lords.
Vegetarians enjoy lichen and seaweed.
Visitors are requested not to apply genocide to shopkeepers.
Watch out, the Wizard might come back.
Water traps have no effect on dragons.
What is a cockatrice going to eat when it gets hungry?
Who needs an apron if they're made of glass?
Why do you suppose they call them MAGIC markers?
Why do you think they call them mercenaries?
Why would anybody in his sane mind engrave "Elbereth"?
Wishing too much may bring you too little.
You can't bribe soldier ants.
You can't leave a shop through the back door:  there isn't one!
You may discover a fine spirit inside a potion bottle.
You may want to dip into a potion of bottled blessings.
You might be able to bribe a demon lord.
You might trick a shopkeeper if you're invisible.
You should certainly learn about quantum mechanics.
You're going into the morgue at midnight???
Your dog knows what to eat; maybe you should take lessons.
Zap yourself and see what happens...
Zapping a wand of undead turning might bring your dog back to life.

# rumors.fal
"So when I die, the first thing I will see in heaven is a score list?"
1st Law of Hacking:  leaving is much more difficult than entering.
2nd Law of Hacking:  first in, first out.
3rd Law of Hacking:  the last blow counts most.
4th Law of Hacking:  you will find the exit at the entrance.
A chameleon imitating a mail daemon often delivers scrolls of fire.
A cockatrice corpse is guaranteed to be untainted!
A dead cockatrice is just a dead lizard.
A dragon is just a snake that ate a scroll of fire.
A fading corridor enlightens your insight.
A glowing potion is too hot to drink.
A good amulet may protect you against guards.
A lizard corpse is a good thing to turn undead.
A long worm can be defined recursively.  So how should you attack it?
A monstrous mind is a toy forever.
A nymph will be very pleased if you call her by her real name:  Lorelei.
A ring of dungeon master control is a great find.
A ring of extra ring finger is useless if not enchanted.
A rope may form a trail in a maze.
A staff may recharge if you drop it for awhile.
A visit to the Zoo is very educational; you meet interesting animals.
A wand of deaf is a more dangerous weapon than a wand of sheep.
A wand of vibration might bring the whole cave crashing about your ears.
A winner never quits.  A quitter never wins.
A wish?  Okay, make me a fortune cookie!
Afraid of mimics?  Try to wear a ring of true seeing.
All monsters are created evil, but some are more evil than others.
Always attack a floating eye from behind!
An elven cloak is always the height of fashion.
Any small object that is accidentally dropped will hide under a larger object.
Archeologists find more bones piles.
Austin Powers says: My Mojo is back!  Yeah, baby!
Balrogs do not appear above level 20.
Banana peels work especially well against Keystone Kops.
Be careful when eating bananas.  Monsters might slip on the peels.
Better leave the dungeon; otherwise you might get hurt badly.
Beware of the potion of nitroglycerin -- it's not for the weak of heart.
Beware:  there's always a chance that your wand explodes as you try to zap it!
Beyond the 23rd level lies a happy retirement in a room of your own.
Changing your suit without dropping your sword?  You must be kidding!
Close the door!  You're letting the heat out!
Cockatrices might turn themselves to stone faced with a mirror.
Consumption of home-made food is strictly forbidden in this dungeon.
Dark room?  Your chance to develop your photographs!
Dark rooms are not *completely* dark:  just wait and let your eyes adjust...
David London sez, "Hey guys, *WIELD* a lizard corpse against a cockatrice!"
Death is just life's way of telling you you've been fired.
Demi-gods don't need any help from the gods.
Demons *HATE* Priests and Priestesses.
Didn't you forget to pay?
Didn't your mother tell you not to eat food off the floor?
Direct a direct hit on your direct opponent, directing in the right direction.
Do you want to make more money?  Sure, we all do!  Join the Fort Ludios guard!
Does your boss know what you're doing right now?
Don't bother wishing for things.  You'll probably find one on the next level.
Don't eat too much:  you might start hiccoughing!
Don't play NetHack at your work; your boss might hit you!
Don't tell a soul you found a secret door, otherwise it isn't a secret anymore.
Drinking potions of booze may land you in jail if you are under 21.
Drop your vanity and get rid of your jewels!  Pickpockets about!
Eat 10 cloves of garlic and keep all humans at a two-square distance.
Eels hide under mud.  Use a unicorn to clear the water and make them visible.
Elf has extra speed.
Engrave your wishes with a wand of wishing.
Eventually you will come to admire the swift elegance of a retreating nymph.
Ever heard hissing outside?  I *knew* you hadn't!
Ever lifted a dragon corpse?
Ever seen a leocrotta dancing the tengu?
Ever seen your weapon glow plaid?
Ever tamed a shopkeeper?
Ever tried digging through a Vault Guard?
Ever tried enchanting a rope?
Floating eyes can't stand Hawaiian shirts.
For any remedy there is a misery.
Giant bats turn into giant vampires.
Good day for overcoming obstacles.  Try a steeplechase.
Half Moon tonight.  (At least it's better than no Moon at all.)
Help!  I'm being held prisoner in a fortune cookie factory!
Housecats have nine lives, kittens only one.
How long can you tread water?
Hungry?  There is an abundance of food on the next level.
I guess you've never hit a mail daemon with the Amulet of Yendor...
If you are the shopkeeper, you can take things for free.
If you ask really nicely, the Wizard will give you the Amulet.
If you can't learn to do it well, learn to enjoy doing it badly.
If you thought the Wizard was bad, just wait till you meet the Warlord!
If you turn blind, don't expect your dog to be turned into a seeing-eye dog.
If you want to feel great, you must eat something real big.
If you want to float, you'd better eat a floating eye.
If your ghost kills a player, it increases your score.
Increase mindpower:  Tame your own ghost!
It furthers one to see the great man.
It's easy to overlook a monster in a wood.
Just below any trap door there may be another one.  Just keep falling!
Katanas are very sharp; watch you don't cut yourself.
Keep a clear mind:  quaff clear potions.
Kicking the terminal doesn't hurt the monsters.
Killer bees keep appearing till you kill their queen.
Killer bunnies can be tamed with carrots only.
Latest news?  Put `rec.games.roguelike.nethack' in your .newsrc!
Learn how to spell.  Play NetHack!
Leprechauns hide their gold in a secret room.
Let your fingers do the walking on the yulkjhnb keys.
Let's face it:  this time you're not going to win.
Let's have a party, drink a lot of booze.
Liquor sellers do not drink; they hate to see you twice.
Lunar eclipse tonight.  May as well quit now!
Meeting your own ghost decreases your luck considerably!
Money to invest?  Take it to the local branch of the Magic Memory Vault!
Monsters come from nowhere to hit you everywhere.
Monsters sleep because you are boring, not because they ever get tired.
Most monsters prefer minced meat.  That's why they are hitting you!
Most of the bugs in NetHack are on the floor.
Much ado Nothing Happens.
Multi-player NetHack is a myth.
NetHack is addictive.  Too late, you're already hooked.
Never ask a shopkeeper for a price list.
Never burn a tree, unless you like getting whacked with a +5 shovel.
Never eat with glowing hands!
Never mind the monsters hitting you:  they just replace the charwomen.
Never play leapfrog with a unicorn.
Never step on a cursed engraving.
Never swim with a camera:  there's nothing to take pictures of.
Never teach your pet rust monster to fetch.
Never trust a random generator in magic fields.
Never use a wand of death.
No level contains two shops.  The maze is no level.  So...
No part of this fortune may be reproduced, stored in a retrieval system, ...
Not all rumors are as misleading as this one.
Nymphs and nurses like beautiful rings.
Nymphs are blondes.  Are you a gentleman?
Offering a unicorn a worthless piece of glass might prove to be fatal!
Old hackers never die:  young ones do.
One has to leave shops before closing time.
One homunculus a day keeps the doctor away.
One level further down somebody is getting killed, right now.
Only a wizard can use a magic whistle.
Only adventurers of evil alignment think of killing their dog.
Only chaotic evils kill sleeping monsters.
Only real trappers escape traps.
Only real wizards can write scrolls.
Operation OVERKILL has started now.
Ouch.  I hate when that happens.
PLEASE ignore previous rumor.
Polymorph into an ettin; meet your opponents face to face to face.
Praying will frighten demons.
Row (3x) that boat gently down the stream, Charon (4x), death is but a dream.
Running is good for your legs.
Screw up your courage!  You've screwed up everything else.
Seepage?  Leaky pipes?  Rising damp?  Summon the plumber!
Segmentation fault (core dumped).
Shopkeepers are insured by Croesus himself!
Shopkeepers sometimes die from old age.
Some mazes (especially small ones) have no solutions, says man 6 maze.
Some questions the Sphynx asks just *don't* have any answers.
Sometimes "mu" is the answer.
Sorry, no fortune this time.  Better luck next cookie!
Spare your scrolls of make-edible until it's really necessary!
Stormbringer doesn't steal souls.  People steal souls.
Suddenly, the dungeon will collapse...
Taming a mail daemon may cause a system security violation.
The crowd was so tough, the Stooges won't play the Dungeon anymore, nyuk nyuk.
The leprechauns hide their treasure in a small hidden room.
The longer the wand the better.
The magic word is "XYZZY".
The meek shall inherit your bones files.
The mines are dark and deep, and I have levels to go before I sleep.
The use of dynamite is dangerous.
There are no worms in the UNIX version.
There is a trap on this level!
They say that Demogorgon, Asmodeus, Orcus, Yeenoghu & Juiblex is no law firm.
They say that Geryon has an evil twin, beware!
They say that Medusa would make a terrible pet.
They say that NetHack bugs are Seldon planned.
They say that NetHack comes in 256 flavors.
They say that NetHack is just a computer game.
They say that NetHack is more than just a computer game.
They say that NetHack is never what it used to be.
They say that a baby dragon is too small to hurt or help you.
They say that a black pudding is simply a brown pudding gone bad.
They say that a black sheep has 3 bags full of wool.
They say that a blank scroll is like a blank check.
They say that a cat named Morris has nine lives.
They say that a desperate shopper might pay any price in a shop.
They say that a diamond dog is everybody's best friend.
They say that a dwarf lord can carry a pick-axe because his armor is light.
They say that a floating eye can defeat Medusa.
They say that a fortune only has 1 line and you can't read between it.
They say that a fortune only has 1 line, but you can read between it.
They say that a fountain looks nothing like a regularly erupting geyser.
They say that a gold doubloon is worth more than its weight in gold.
They say that a grid bug won't pay a shopkeeper for zapping you in a shop.
They say that a gypsy could tell your fortune for a price.
They say that a hacker named Alice once level teleported by using a mirror.
They say that a hacker named David once slew a giant with a sling and a rock.
They say that a hacker named Dorothy once rode a fog cloud to Oz.
They say that a hacker named Mary once lost a white sheep in the mazes.
They say that a helm of brilliance is not to be taken lightly.
They say that a hot dog and a hell hound are the same thing.
They say that a lamp named Aladdin's Lamp contains a djinni with 3 wishes.
They say that a large dog named Lassie will lead you to the amulet.
They say that a long sword is not a light sword.
They say that a manes won't mince words with you.
They say that a mind is a terrible thing to waste.
They say that a plain nymph will only wear a wire ring in one ear.
They say that a plumed hat could be a previously used crested helmet.
They say that a potion of oil is difficult to grasp.
They say that a potion of yogurt is a cancelled potion of sickness.
They say that a purple worm is not a baby purple dragon.
They say that a quivering blob tastes different than a gelatinous cube.
They say that a runed broadsword named Stormbringer attracts vortices.
They say that a scroll of summoning has other names.
They say that a shaman can bestow blessings but usually doesn't.
They say that a shaman will bless you for an eye of newt and wing of bat.
They say that a shimmering gold shield is not a polished silver shield.
They say that a spear will hit a neo-otyugh.  (Do YOU know what that is?)
They say that a spotted dragon is the ultimate shape changer.
They say that a stethoscope is no good if you can only hear your heartbeat.
They say that a succubus named Suzy will sometimes warn you of danger.
They say that a wand of cancellation is not like a wand of polymorph.
They say that a wood golem named Pinocchio would be easy to control.
They say that after killing a dragon it's time for a change of scenery.
They say that an amulet of strangulation is worse than ring around the collar.
They say that an attic is the best place to hide your toys.
They say that an axe named Cleaver once belonged to a hacker named Beaver.
They say that an eye of newt and a wing of bat are double the trouble.
They say that an incubus named Izzy sometimes makes women feel sensitive.
They say that an opulent throne room is rarely a place to wish you'd be in.
They say that an unlucky hacker once had a nose bleed at an altar and died.
They say that and they say this but they never say never, never!
They say that any quantum mechanic knows that speed kills.
They say that applying a unicorn horn means you've missed the point.
They say that blue stones are radioactive, beware.
They say that building a dungeon is a team effort.
They say that chaotic characters never get a kick out of altars.
They say that collapsing a dungeon often creates a panic.
They say that counting your eggs before they hatch shows that you care.
They say that dipping a bag of tricks in a fountain won't make it an icebox.
They say that dipping an eel and brown mold in hot water makes bouillabaisse.
They say that donating a doubloon is extremely pious charity.
They say that dungeoneers prefer dark chocolate.
They say that eating royal jelly attracts grizzly owlbears.
They say that eggs, pancakes and juice are just a mundane breakfast.
They say that everyone knows why Medusa stands alone in the dark.
They say that everyone wanted rec.games.hack to undergo a name change.
They say that finding a winning strategy is a deliberate move on your part.
They say that finding worthless glass is worth something.
They say that fortune cookies are food for thought.
They say that gold is only wasted on a pet dragon.
They say that good things come to those that wait.
They say that greased objects will slip out of monsters' hands.
They say that if you can't spell then you'll wish you had a spellbook.
They say that if you live by the sword, you'll die by the sword.
They say that if you play like a monster you'll have a better game.
They say that if you sleep with a demon you might awake with a headache.
They say that if you step on a crack you could break your mother's back.
They say that if you're invisible you can still be heard!
They say that if you're lucky you can feel the runes on a scroll.
They say that in the big picture gold is only small change.
They say that in the dungeon it's not what you know that really matters.
They say that in the dungeon moon rocks are really dilithium crystals.
They say that in the dungeon the boorish customer is never right.
They say that in the dungeon you don't need a watch to tell time.
They say that in the dungeon you need something old, new, burrowed and blue.
They say that in the dungeon you should always count your blessings.
They say that iron golem plate mail isn't worth wishing for.
They say that it takes four quarterstaffs to make one staff.
They say that it's not over till the fat ladies sing.
They say that it's not over till the fat lady shouts `Off with its head'.
They say that kicking a heavy statue is really a dumb move.
They say that kicking a valuable gem doesn't seem to make sense.
They say that leprechauns know Latin and you should too.
They say that minotaurs get lost outside of the mazes.
They say that most trolls are born again.
They say that naming your cat Garfield will make you more attractive.
They say that no one knows everything about everything in the dungeon.
They say that no one plays NetHack just for the fun of it.
They say that no one really subscribes to rec.games.roguelike.nethack.
They say that no one will admit to starting a rumor.
They say that nurses sometimes carry scalpels and never use them.
They say that once you've met one wizard you've met them all.
They say that one troll is worth 10,000 newts.
They say that only David can find the zoo!
They say that only angels play their harps for their pets.
They say that only big spenders carry gold.
They say that orc shamans are healthy, wealthy and wise.
They say that playing NetHack is like walking into a death trap.
They say that problem breathing is best treated by a proper diet.
They say that quaffing many potions of levitation can give you a headache.
They say that queen bees get that way by eating royal jelly.
They say that reading a scare monster scroll is the same as saying Elbereth.
They say that real hackers always are controlled.
They say that real hackers never sleep.
They say that shopkeepers are insured by Croesus himself!
They say that shopkeepers never carry more than 20 gold pieces, at night.
They say that shopkeepers never sell blessed potions of invisibility.
They say that soldiers wear kid gloves and silly helmets.
They say that some Kops are on the take.
They say that some guards' palms can be greased.
They say that some monsters may kiss your boots to stop your drum playing.
They say that sometimes you can be the hit of the party when playing a horn.
They say that the NetHack gods generally welcome your sacrifices.
They say that the Three Rings are named Vilya, Nenya and Narya.
They say that the Wizard of Yendor has a death wish.
They say that the `hair of the dog' is sometimes an effective remedy.
They say that the best time to save your game is now before it's too late.
They say that the biggest obstacle in NetHack is your mind.
They say that the gods are angry when they hit you with objects.
They say that the priesthood are specially favored by the gods.
They say that the way to make a unicorn happy is to give it what it wants.
They say that there are no black or white stones, only gray.
They say that there are no skeletons hence there are no skeleton keys.
They say that there is a clever rogue in every hacker just dying to escape.
They say that there is no such thing as free advice.
They say that there is only one way to win at NetHack.
They say that there once was a fearsome chaotic samurai named Luk No.
They say that there was a time when cursed holy water wasn't water.
They say that there's no point in crying over a gray ooze.
They say that there's only hope left after you've opened Pandora's box.
They say that trap doors should always be marked `Caution:  Trap Door'.
They say that using an amulet of change isn't a difficult operation.
They say that water walking boots are better if you are fast like Hermes.
They say that when you wear a circular amulet you might resemble a troll.
They say that when you're hungry you can get a pizza in 30 moves or it's free.
They say that when your god is angry you should try another one.
They say that wielding a unicorn horn takes strength.
They say that with speed boots you never worry about hit and run accidents.
They say that you can defeat a killer bee with a unicorn horn.
They say that you can only cross the River Styx in Charon's boat.
They say that you can only kill a lich once and then you'd better be careful.
They say that you can only wish for things you've already had.
They say that you can train a cat by talking gently to it.
They say that you can train a dog by talking firmly to it.
They say that you can trust your gold with the king.
They say that you can't wipe your greasy bare hands on a blank scroll.
They say that you cannot trust scrolls of rumor.
They say that you could fall head over heels for an energy vortex.
They say that you need a key in order to open locked doors.
They say that you need a mirror to notice a mimic in an antique shop.
They say that you really can use a pick-axe unless you really can't.
They say that you should always store your tools in the cellar.
They say that you should be careful while climbing the ladder to success.
They say that you should call your armor `rustproof'.
They say that you should name your dog Spuds to have a cool pet.
They say that you should name your weapon after your first monster kill.
They say that you should never introduce a rope golem to a succubus.
They say that you should never sleep near invisible ring wraiths.
They say that you should never try to leave the dungeon with a bag of gems.
They say that you should remove your armor before sitting on a throne.
This fortune cookie is copy protected.
This fortune cookie is the property of Fortune Cookies, Inc.
This release contains 10% recycled material.
Time stands still as the succubus changes her calendar to January 1, 2000.
Tired?  Try a scroll of charging on yourself.
To achieve the next higher rating, you need 3 more points.
To reach heaven, escape the dungeon while wearing a ring of levitation.
Tourists wear shirts loud enough to wake the dead.
Try calling your katana Moulinette.
Ulch!  That meat was painted!
Unfortunately, this message was left intentionally blank.
Using a morning star in the evening has no effect.
Waltz, dumb nymph, for quick jigs vex.
Want a hint?  Zap a wand of make invisible on your weapon!
Want to ascend in a hurry?  Apply at Gizmonic Institute.
Wanted: shopkeepers.  Send a scroll of mail to Mage of Yendor/Level 35/Dungeon.
Warning:  fortune reading can be hazardous to your health.
We have new ways of detecting treachery...
Wet towels make great weapons!
What a pity, you cannot read it!
Whatever can go wrong, will go wrong.
When a piercer drops in on you, you will be tempted to hit the ceiling!
When in a maze follow the right wall and you will never get lost.
When you have a key, you don't have to wait for the guard.
Why are you wasting time reading fortunes?
Wish for a master key and open the Magic Memory Vault!
Wizard expects every monster to do its duty.
Wow!  You could've had a potion of fruit juice!
Yet Another Silly Message (YASM).
You are destined to be misled by a fortune.
You can get a genuine Amulet of Yendor by doing the following:  --More--
You can make holy water by boiling the hell out of it.
You can protect yourself from black dragons by doing the following:  --More--
You can't get by the snake.
You choke on the fortune cookie.  --More--
You feel like someone is pulling your leg.
You have to outwit the Sphynx or pay her.
You hear the fortune cookie's hissing!
You may get rich selling letters, but beware of being blackmailed!
You offend Shai-Hulud by sheathing your crysknife without having drawn blood.
You swallowed the fortune!
You want to regain strength?  Two levels ahead is a guesthouse!
You will encounter a tall, dark, and gruesome creature...

# Other
Closed for inventory
