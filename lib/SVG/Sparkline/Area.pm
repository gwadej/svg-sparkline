package SVG::Sparkline::Area;

use warnings;
use strict;
use Carp;
use SVG;
use SVG::Sparkline::Utils;

use 5.008000;
our $VERSION = '0.2.5';

# aliases to make calling shorter.
*_f = *SVG::Sparkline::Utils::format_f;

sub make
{
    my ($class, $args) = @_;
    # validate parameters
    SVG::Sparkline::Utils::validate_array_param( $args, 'values' );
    my $valdesc = SVG::Sparkline::Utils::summarize_xy_values( $args->{values} );
    $valdesc->{vals} = [ map { [$_->[0], $_->[1]+$valdesc->{ymin}] } @{$valdesc->{vals}} ];

    $args->{width} ||= @{$valdesc->{vals}};
    my $xscale = ($args->{width}-1) / $valdesc->{xrange};
    my $yscale = -$args->{height} / $valdesc->{yrange};
    my $baseline = _f(-$yscale*$valdesc->{ymin});

    my $zero = -($baseline+$args->{height});
    my $svg = SVG::Sparkline::Utils::make_svg(
        width=>$args->{width}, height=>$args->{height},
        viewBox=> "0 $zero $args->{width} $args->{height}",
    );
    SVG::Sparkline::Utils::add_bgcolor( $svg, -$args->{height}, $args );

    my $points = join( ' ', "0,0",
        ( map { _f($xscale*$_->[0]) .','. _f($yscale*$_->[1]) } @{$valdesc->{vals}} ),
        _f($xscale * $valdesc->{vals}->[-1]->[0]).",0"
    );
    $svg->polygon( fill=>$args->{color}, points=>$points, stroke=>'none' );

    if( exists $args->{mark} )
    {
        _make_marks( $svg,
            xscale=>$xscale, yscale=>$yscale, base=>$zero,
            values=>$args->{values}, mark=>$args->{mark}
        );
    }

    return $svg;
}

sub _make_marks
{
    my ($svg, %args) = @_;
    
    my @marks = @{$args{mark}};
    my @yvalues = @{$args{values}};
    while(@marks)
    {
        my ($index,$color) = splice( @marks, 0, 2 );
        $index = SVG::Sparkline::Utils::mark_to_index( 'Area', $index, \@yvalues );
        _make_mark( $svg, %args, index=>$index, color=>$color );
    }
    return;
}

sub _make_mark
{
    my ($svg, %args) = @_;
    my $index = $args{index};
    my $h = _f($args{values}->[$index] * $args{yscale});
    my $x = _f($args{xscale} * $index);
    my $y = _f($args{yscale} * $args{values}->[$index]);
    my $base = _f($args{yscale} * $args{base});
    $svg->line( x1=>$x, y1=>$base, x2=>$x, y2=>$y,
        fill=>'none', stroke=>$args{color}, 'stroke-width'=>1
    );
    return;
}

1; # Magic true value required at end of module
__END__

=head1 NAME

SVG::Sparkline::Area - Supports SVG::Sparkline for area graphs.

=head1 VERSION

This document describes SVG::Sparkline::Area version 0.2.5

=head1 DESCRIPTION

Not used directly. This module provides a factory interface to build
a 'Area' sparkline. It is loaded on demand by L<SVG::Sparkline>.

=head1 INTERFACE 

=head2 make

Create an L<SVG> object that represents the Area style of Sparkline.

=head1 DIAGNOSTICS

=over

=item C<< Missing required '%s' parameter. >>

The named parameter is not supplied.

=item C<< '%s' must be an array reference. >>

The named parameter was not an array reference.

=item C<< No values for '%s' specified. >>

The supplied array has no values.

=item C<< Count of 'x' and 'y' values must match. >>

The two arrays have different numbers of values.

=back


=head1 CONFIGURATION AND ENVIRONMENT

SVG::Sparkline::Line requires no configuration files or environment variables.

=head1 DEPENDENCIES

L<Carp>, L<SVG>, L<SVG::Sparkline::Utils>.

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

