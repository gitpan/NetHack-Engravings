package NetHack::Engravings;
BEGIN {
  $NetHack::Engravings::AUTHORITY = 'cpan:DOY';
}
{
  $NetHack::Engravings::VERSION = '0.01';
}
use strict;
use warnings;
# ABSTRACT: functions related to NetHack engravings

use Exporter 'import';
our @EXPORT_OK = ('is_degradation');


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


1;

__END__

=pod

=head1 NAME

NetHack::Engravings - functions related to NetHack engravings

=head1 VERSION

version 0.01

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

  The GNU General Public License, Version 2, June 1991

=cut
