package SVG::Sparkline::Bar;

use warnings;
use strict;
use Carp;
use SVG;
use SVG::Sparkline::Utils;

use 5.008000;
our $VERSION = '0.2.6';

# alias to make calling shorter.
*_f = *SVG::Sparkline::Utils::format_f;

sub make
{
    my ($class, $args) = @_;
    # validate parameters
    SVG::Sparkline::Utils::validate_array_param( $args, 'values' );
    my $vals = SVG::Sparkline::Utils::summarize_values( $args->{values} );

    my $height = $args->{height} - 2*$args->{pady};
    my $yscale = -$height / $vals->{range};
    my $baseline = _f(-$yscale*$vals->{min});

    # Figure out the width I want and define the viewBox
    my $dwidth;
    if($args->{width})
    {
        $dwidth = $args->{width} - $args->{padx}*2;
        $args->{xscale} = _f( $dwidth / @{$args->{values}} );
    }
    else
    {
        $args->{xscale} ||= 3;
        $dwidth = @{$args->{values}} * $args->{xscale};
        $args->{width} = $dwidth + 2*$args->{padx}; 
    }
    $args->{yoff} = -($baseline+$height+$args->{pady});
    my $svg = SVG::Sparkline::Utils::make_svg( $args );

    my $prev = 0;
    my $path = "M0,0";
    foreach my $v (@{$args->{values}})
    {
        my $curr = _f( $yscale*($v-$prev) );
        $path .= "v$curr" if $curr;
        $path .= "h$args->{xscale}";
        $prev = $v;
    }
    $path .= 'v' . _f( $yscale*(-$prev) ) if $prev;
    $path .= 'z';
    $svg->path( stroke=>'none', fill=>$args->{color}, d=>$path );

    if( exists $args->{mark} )
    {
        _make_marks( $svg,
            thick=>$args->{xscale}, yscale=>$yscale,
            values=>$args->{values}, mark=>$args->{mark}
        );
    }
    return $svg;
}

sub _make_marks
{
    my ($svg, %args) = @_;
    
    my @marks = @{$args{mark}};
    while(@marks)
    {
        my ($index,$color) = splice( @marks, 0, 2 );
        $index = _check_index( $index, $args{values} );
        _make_mark( $svg, %args, index=>$index, color=>$color );
    }
    return;
}

sub _make_mark
{
    my ($svg, %args) = @_;
    my $index = $args{index};
    my $h = _f($args{values}->[$index] * $args{yscale});
    return unless $h;
    my $x = _f($index * $args{thick});
    my $y = $h > 0 ? 0 : $h;
    $svg->rect( x=>$x, y=>$y,
        width=>$args{thick}, height=>abs($h),
        stroke=>'none', fill=>$args{color}
    );
    return;
}

sub _check_index
{
    return SVG::Sparkline::Utils::mark_to_index( 'Bar', @_ );
}


1; # Magic true value required at end of module
__END__

=head1 NAME

SVG::Sparkline::Bar - Supports SVG::Sparkline for bar graphs.

=head1 VERSION

This document describes SVG::Sparkline::Bar version 0.2.5

=head1 DESCRIPTION

Not used directly. This module provides a factory interface to build
a 'Bar' sparkline. It is loaded on demand by L<SVG::Sparkline>.

=head1 INTERFACE 

=head2 make

Create an L<SVG> object that represents the Bar style of Sparkline.

=head1 DIAGNOSTICS

=over

=item C<< Missing required '%s' parameter. >>

The named parameter is not supplied.

=item C<< '%s' must be an array reference. >>

The named parameter was not an array reference.

=item C<< No values for '%s' specified. >>

The supplied array has no values.

=back

=head1 CONFIGURATION AND ENVIRONMENT

SVG::Sparkline::Bar requires no configuration files or environment variables.

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

