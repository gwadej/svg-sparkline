package SVG::Sparkline::Whisker;

use warnings;
use strict;
use Carp;
use SVG;
use SVG::Sparkline::Utils;

use 5.008000;
our $VERSION = '0.1.0';

# alias to make calling shorter.
*_f = *SVG::Sparkline::Utils::format_f;

sub make
{
    my ($class, $args) = @_;
    # validate parameters
    my @values;
    if( 'ARRAY' eq ref $args->{y} )
    {
        @values =  @{$args->{y}};
    }
    elsif( !ref $args->{y} )
    {
        @values = split //, $args->{y};
    }
    else
    {
        croak "Unrecognized type of 'y' data.\n";
    }
    @values =  map { _val( $_ ) } @values;
    croak "No values specified for 'y'.\n" unless @values;

    # Figure out the width I want and define the viewBox
    my $thick = 1;
    my $space = 3*$thick;
    if($args->{width})
    {
        $thick = _f( $args->{width} / (3*@values) );
        $space = 3*$thick;
    }
    else
    {
        $args->{width} = @values * $space;
    }
    ++$space if $space =~s/\.9\d$//;
    my $wheight = $args->{height}/2;

    my $svg = SVG::Sparkline::Utils::make_svg(
        width=>$args->{width}, height=>$args->{height},
        viewBox=> "0 -$wheight $args->{width} $args->{height}",
    );

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

    return $svg;
}

sub _val
{
    my $y = shift;

    return $y <=> 0 if $y =~ /\d/;
    return $y eq '+' ? 1 : ( $y eq '-' ? -1 : 0 );
}


1; # Magic true value required at end of module
__END__

=head1 NAME

SVG::Sparkline::Whisker - Supports SVG::Sparkline for whisker graphs.

=head1 VERSION

This document describes SVG::Sparkline::Whisker version 0.1.0

=head1 DESCRIPTION

Not used directly. This module provides a factory interface to build
a 'Whisker' sparkline. It is loaded on demand by L<SVG::Sparkline>.

=head1 INTERFACE 

=head2 make

Create an L<SVG> object that represents the Whisker style of Sparkline.

=head1 DIAGNOSTICS

=over 4

=item C<< Unrecognized type of 'y' data. >>

The I<y> parameter only supports strings of {'-','+','0'}, {'0','1'}, or
a reference to an array of numbers.

=item C<< No values specified for 'y'. >>

An empty array was supplied for the I<y> parameter.

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

