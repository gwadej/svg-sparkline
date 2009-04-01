package SVG::Sparkline::Area;

use warnings;
use strict;
use Carp;
use SVG;
use SVG::Sparkline::Utils;

use 5.008000;
our $VERSION = '0.0.3';

# aliases to make calling shorter.
*_f = *SVG::Sparkline::Utils::format_f;
*_vals = *SVG::Sparkline::Utils::summarize_values;

sub make
{
    my ($class, $args) = @_;
    # validate parameters
    croak "Missing required 'y' parameter.\n"
        if !exists $args->{y} or 'ARRAY' ne ref $args->{y};
    croak "Missing required 'x' parameter.\n"
        if !exists $args->{x} or 'ARRAY' ne ref $args->{x};
    croak "No values for 'y' specified.\n" unless @{$args->{y}};
    croak "No values for 'x' specified.\n" unless @{$args->{x}};
    croak "Count of 'x' and 'y' values must match.\n"
        unless @{$args->{x}} == @{$args->{y}};
    croak "Missing required 'width' parameter.\n"
        if !exists $args->{width} or $args->{width} < 1;

    # Figure out the width I want and define the viewBox
    my $xvals = _vals( $args->{x} );
    my $yvals = _vals( $args->{y} );

    my $xscale = $args->{width} / $xvals->{range};
    my $yscale = $args->{height} / $yvals->{range};

    my $svg = SVG::Sparkline::Utils::make_svg(
        width=>$args->{width}, height=>$args->{height},
        viewBox=> "0 -$args->{height} $args->{width} $args->{height}",
    );

    my $points = join( ' ', '0,0',
        map { _f($xscale*$xvals->{vals}->[$_]) .','. _f(-$yscale*$yvals->{vals}->[$_]) }
        0 .. $#{$xvals->{vals}}
    );
    $svg->polygon( fill=>$args->{color}, points=>$points );

    return $svg;
}

1; # Magic true value required at end of module
__END__

=head1 NAME

SVG::Sparkline::Line - [One line description of module's purpose here]


=head1 VERSION

This document describes SVG::Sparkline::Line version 0.0.3


=head1 SYNOPSIS

    use SVG::Sparkline::Line;

=head1 DESCRIPTION

Not used directly. This module provides a factory interface to build
a 'Area' sparkline. It is loaded on demand by L<SVG::Sparkline>.

=head1 INTERFACE 

=head2 make

Create an L<SVG> object that represents the Area style of Sparkline.

=head1 DIAGNOSTICS

=for author to fill in:
    List every single error and warning message that the module can
    generate (even the ones that will "never happen"), with a full
    explanation of each problem, one or more likely causes, and any
    suggested remedies.

=over

=item C<< Error message here, perhaps with %s placeholders >>

[Description of error here]

=item C<< Another error message here >>

[Description of error here]

[Et cetera, et cetera]

=back


=head1 CONFIGURATION AND ENVIRONMENT

SVG::Sparkline::Line requires no configuration files or environment variables.

=head1 DEPENDENCIES

L<Carp>, L<SVG>, L<SVG::Sparkline>.

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

