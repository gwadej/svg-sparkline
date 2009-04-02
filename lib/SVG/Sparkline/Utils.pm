package SVG::Sparkline::Utils;

use warnings;
use strict;
use Carp;
use List::Util;
use SVG;

our $VERSION = '0.1.0';

sub format_f
{
    my $val = sprintf '%.02f', $_[0];
    $val =~ s/0$//;
    $val =~ s/\.0$//;
    $val = 0 if $val eq '-0';
    return $val;
}

sub summarize_values
{
    my ($array) = @_;
    my $desc = {
        min => List::Util::min( @{$array} ),
        max => List::Util::max( @{$array} ),
    };

    $desc->{range} = $desc->{max}-$desc->{min};
    push @{$desc->{vals}}, $_-$desc->{min} foreach @{$array};
    return $desc;
}

sub make_svg
{
    return SVG->new(
        -inline=>1, -nocredits=>1, -raiseerror=>1, -indent=>'', -elsep=>'',
        @_
    );
}

sub validate_array_param
{
    my ($args, $name) = @_;
    local $Carp::CarpLevel = 2;
    croak "Missing required '$name' parameter.\n"
        if !exists $args->{$name} or 'ARRAY' ne ref $args->{$name};
    croak "No values for '$name' specified.\n" unless @{$args->{$name}};
    return;
}

1; # Magic true value required at end of module
__END__

=head1 NAME

SVG::Sparkline::Utils - Utility functions used by the sparkline type modules.

=head1 VERSION

This document describes SVG::Sparkline::Utils version 0.1.0

=head1 DESCRIPTION

This module is not intended to be used directly. It is provided to support
the different types of sparklines.

=head1 INTERFACE 

=head2 format_f

Convert numeric data to a reasonable output format for sparkline-sized SVG.
No more than 2 decimal places are displayed and all trailing zeros after
the decimal place are removed.

=head2 make_svg

Create the SVG object with the proper base parameters for a sparkline. Apply
the supplied parameters as well.

=head2 summarize_values

Given a list of numeric values generate a structured summary simplifying
changes for later. Calculate I<min>, I<max>, I<range>, and generate a
list of all values after subtracting the I<min>.

=head2 validate_array_param

Validate an array parameter or throw an exception.

=head1 DIAGNOSTICS

The diagnostics are reported where they are emitted by the library.

=head1 CONFIGURATION AND ENVIRONMENT

SVG::Sparkline::Utils requires no configuration files or environment variables.

=head1 DEPENDENCIES

L<SVG>, L<List::Util>.

=head1 INCOMPATIBILITIES

None reported.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

=head1 AUTHOR

G. Wade Johnson  C<< wade@anomaly.org >>

=head1 LICENCE AND COPYRIGHT

Copyright (c) 2009, G. Wade Johnson C<< wade@anomaly.org >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.

