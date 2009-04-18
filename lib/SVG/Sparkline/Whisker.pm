package SVG::Sparkline::Whisker;

use warnings;
use strict;
use Carp;
use SVG;
use SVG::Sparkline::Utils;

use 5.008000;
our $VERSION = '0.2.5';

# alias to make calling shorter.
*_f = *SVG::Sparkline::Utils::format_f;

sub make
{
    my ($class, $args) = @_;
    # validate parameters
    my @values;
    croak "Missing required 'values'\n" unless exists $args->{values};
    if( 'ARRAY' eq ref $args->{values} )
    {
        @values =  @{$args->{values}};
    }
    elsif( !ref $args->{values} )
    {
        my $valstr = $args->{values};
        # Convert 1/0 string to a +/- string.
        $valstr =~ tr/10/+-/ if $valstr =~ /1/;

        @values = split //, $valstr;
    }
    else
    {
        croak "Unrecognized type of 'values' data.\n";
    }
    @values =  map { _val( $_ ) } @values;
    croak "No values specified for 'values'.\n" unless @values;

    # Figure out the width I want and define the viewBox
    my $thick = 1;
    my $space = 3*$thick;
    my $dwidth;
    if($args->{width})
    {
        $dwidth = $args->{width} - 2*$args->{padx};
        $thick = _f( $dwidth / (3*@values) );
        $space = 3*$thick;
    }
    else
    {
        $dwidth = @values * $space;
        $args->{width} = $dwidth + 2*$args->{padx};
    }
    ++$space if $space =~s/\.9\d$//;
    my $height = $args->{height} - 2*$args->{pady};
    my $wheight = $args->{height}/2;
    $args->{yoff} = -$wheight;
    $wheight -= $args->{pady};
    my $svg = SVG::Sparkline::Utils::make_svg( $args );

    my $path = "M$thick,0";
    foreach my $v (@values)
    {
        if( $v )
        {
            my ($u,$d) = ( -$v*$wheight, $v*$wheight );
            $path .= "v${u}m$space,${d}";
        }
        else
        {
            $path .= "m$space,0";
        }
    }
    $svg->path( 'stroke-width'=>$thick, stroke=>$args->{color}, d=>$path );

    if( exists $args->{mark} )
    {
        _make_marks( $svg,
           thick=>$thick, space=>$space, wheight=>-$wheight,
           values=>\@values, mark=>$args->{mark}
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
    return unless $args{values}->[$index];
    my $x = $index * $args{space}+$args{thick};
    $svg->line( x1=>$x, x2=>$x, y1=>0, y2=>$args{wheight} * $args{values}->[$index],
        'stroke-width'=>$args{thick}, stroke=>$args{color}
    );
    return;
}

sub _check_index
{
    my ($index, $values) = @_;
    return 0 if $index eq 'first';
    return $#{$values} if $index eq 'last';
    return $index unless $index =~ /\D/;

    die "'$index' is not a valid mark for Whisker sparkline";
}

sub _val
{
    my $val = shift;

    return $val <=> 0 if $val =~ /\d/;
    return $val eq '+' ? 1 : ( $val eq '-' ? -1 : die "Unrecognized character '$val'\n" );
}


1; # Magic true value required at end of module
__END__

=head1 NAME

SVG::Sparkline::Whisker - Supports SVG::Sparkline for whisker graphs.

=head1 VERSION

This document describes SVG::Sparkline::Whisker version 0.2.5

=head1 DESCRIPTION

Not used directly. This module provides a factory interface to build
a 'Whisker' sparkline. It is loaded on demand by L<SVG::Sparkline>.

=head1 INTERFACE 

=head2 make

Create an L<SVG> object that represents the Whisker style of Sparkline.

=head1 DIAGNOSTICS

=over 4

=item C<< Missing required '%s' parameter. >>

The named parameter is not supplied.

=item C<< Unrecognized type of 'values' data. >>

The I<values> parameter only supports strings of {'-','+','0'}, {'0','1'}, or
a reference to an array of numbers.

=item C<< No values specified for 'values'. >>

An empty array was supplied for the I<values> parameter.

=back

=head1 CONFIGURATION AND ENVIRONMENT

SVG::Sparkline::Whisker requires no configuration files or environment variables.

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

