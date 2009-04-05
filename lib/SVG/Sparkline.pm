package SVG::Sparkline;

use warnings;
use strict;
use Carp;
use SVG;

use 5.008000;
our $VERSION = '0.2.0';

sub new
{
    my ($class, $type, $args) = @_;
    croak "No Sparkline type specified.\n" unless defined $type;
    # Use eval to load plugin.
    eval "use SVG::Sparkline::$type;";  ## no critic (ProhibitStringyEval)
    croak "Unrecognized Sparkline type '$type'.\n" if $@;
    croak "Missing arguments hash.\n" unless defined $args;
    croak "Arguments not supplied as a hash reference.\n" unless 'HASH' eq ref $args;

    my $self = bless {
        height => 10,
        width => 0,
        -nodecl => 0,
        -allns => 0,
        color => '#000',
        %{$args},
    }, $class;

    $self->_make( $type );

    return $self;
}

sub _make {
    my ($self, $type) = @_;
    # Disable strict to allow calling method from plugin.
    no strict 'refs'; ## no critic (ProhibitNoStrict)
    $self->{_SVG} = "SVG::Sparkline::$type"->make( $self );
    return;
}

sub to_string
{
    my ($self) = @_;
    my $str = $self->{_SVG}->xmlify();
    # Cleanup
    $str =~ s/ xmlns:(?:svg|xlink)="[^"]+"//g unless $self->{'-allns'};
    $str =~ s/<\?[^\?]+\?>// if $self->{'-nodecl'};
    return $str;
}

1; # Magic true value required at end of module
__END__

=head1 NAME

SVG::Sparkline - Create Sparklines in SVG


=head1 VERSION

This document describes SVG::Sparkline version 0.2.0

=head1 SYNOPSIS

    use SVG::Sparkline;

    my $sl1 = SVG::Sparkline->new( Whisker => { values=>\@values, color=>'#eee', height=>12 } );
    print $sl1->to_string();

    my $sl2 = SVG::Sparkline->new( Line => { values=>\@values, color=>'blue', height=>12 } );
    print $sl2->to_string();

    my $sl3 = SVG::Sparkline->new( Area => { values=>\@values, color=>'green', height=>10 } );
    print $sl3->to_string();

    my $sl4 = SVG::Sparkline->new( Bar => { values=>\@values, color=>'#66f', height=>10 } );
    print $sl4->to_string();
  
=head1 DESCRIPTION

In the book I<Beautiful Evidence>, Edward Tufte describes sparklines as
I<small, high-resolution, graphics embedded in a context of words, numbers, images>. 

This module provides a relatively easy interface for creating different
kinds of sparklines. This class is not intended to be used to build large,
complex graphs (there are other modules much more suited to that job). The
focus here is on the kinds of data well-suited to the sparklines concept.

Although the basics are there, this module is not yet feature complete.

=head1 INTERFACE 

=head2 CVG::Sparkline->new( $type, $args_hr )

Create a new L<SVG::Sparkline> object of the specified type, using the
parameters in the C<$args_hr> hash reference. There are two groups of
parameters. Parameters that start with a B<-> character control the
L<SVG::Sparkline> object. Parameters that do not start with B<-> are used
in attributes in the sparkline itself.

=head3 Configuration Parameters

Configuration parameters are independent of the type of sparkline being
generated.

=over 4

=item -nodecl

The value of this parameter is a boolean that specifies whether the XML
declaration statement is to be removed from the generated SVG.

If you are embedding the SVG content directly in another document (maybe
HTML), you should pass this parameter with a 1. If you are generating a
standalone sparkline document, you should pass a 0.

The I<-nodecl> parameter defaults to 0.

=item -allns

The value of this parameter is a boolean that specifies whether to supply
all potential namespace attributes relating to SVG.

If the value of the parameter is 0 or the parameter is not supplied, only
the default SVG namespace is included in the sparkline.

If the value of the parameter is 1, a namespace is supplied for the prefix
I<svg> and the prefix I<xlink>.

=item -bgcolor

The value of this parameter is an SVG-supported color string which specifies
a color for the background of the sparkline. In general, this parameter should
not be supplied or should be very subtle to avoid taking attention away from
the actual data displayed.

=back

=head3 Attribute Parameters

The attribute parameters passed in C<$args_hr> depend somewhat on the
C<$type>. However, some are common.

=over 4

=item height

This optional parameter specifies the height of the Sparkline in pixels.
The data for the sparkline is scaled to fit this height. If not specified,
the default height is 10 pixels.

=item width

This parameter specifies the width of the Sparkline in pixels. All data is
scaled to fit this width. The default value of the I<width> parameter depends
on the sparkline type.

=item values

This parameter specifies the data to be displayed by the sparkline. The actual
form of this data is determined by the sparkline type.

=item color

This optional parameter specifies the color for the displayed data as an
SVG supported color string. Each sparkline type uses this color slightly
differently.

=back

The supported graph types are: B<Area>, B<Bar>, B<Line>, and B<Whisker>.
Each type is described below with any parameters specific to that type.

=head3 Area

An C<Area> sparkline is a basic line graph with shaded between the line and
the x axis. The supplied I<color> attribute determines the shading.

=over 4

=item values

The value of this parameter is a reference to an array. This array is either
an array of numeric values representing the y-values of the data to be plotted,
or an array of anonymous arrays, each containing an x-value and a y-value.

=item width

This parameter is optional for the I<Area> sparkline type. The value is the width
of the sparkline in pixels. The default value for this parameter is the number of
items in the I<values> parameter.

=item color

This optional parameter specifies the color of the filled area between the
data line and the x-axis as a SVG supported color string. The default value
for this parameter is I<#000> (black).

=back

=head3 Bar

The I<Bar> sparkline type is a simple bar graph. This sparkline type does not
require any I<x> values.

=over 4

=item values

The I<values> parameter is required for the I<Bar> sparkline type. The
value must be a reference to an array of numeric values, specifying the
height of the corresponding bar.

=item thick

This optional parameter specifies the thickness of the individual bars on the
bar graph. This parameter is ignored if the I<width> parameter is specified.
If neither I<width> or I<thick> are specified, the default value of I<thick>
is 3.

=item width

This optional parameter specifies the width of the sparkline in pixels. If
the I<width> is not specified, the width of the sparkline is the value of
I<thick> times the number of I<values>.

=item color

This optional parameter specifies the color of the filled area between the
data line and the x-axis as a SVG supported color string. The default value
for this parameter is I<#000> (black).

=back

=head3 Line

The I<Line> sparkline type is a simple line graph. Both I<x> and I<y> values
are required for I<Line> sparklines.

=over 4

=item values

The value of this parameter is a reference to an array. This array is either
an array of numeric values representing the y-values of the data to be plotted,
or an array of anonymous arrays, each containing an x-value and a y-value.

=item width

This parameter is optional for the I<Area> sparkline type. The value is the width
of the sparkline in pixels. The default value for this parameter is the number of
items in the I<values> parameter.

=item thick

This optional parameter specifies the thickness of the data line in pixels.
If not specified, the default value is 1 pixel.

=item color

This optional parameter specifies the color of the data line as a SVG supported
color string. The default value for this parameter is I<#000> (black).

=back

=head3 Whisker

The I<Whisker> sparkline type shows a sequence of events that can have one
of two outcomes (e.g. win/loss). A short line upwards is one of the outcomes
and a short line downward is the other outcome. There is also a third possible
where no tick is displayed.

=over 4

=item values

The I<values> parameter is required for the I<Whisker> sparkline type.
The value can be one of three things:

=over 4

=item string of '+', '-', or '0'

Where '+' means an uptick, '-' is a down tick, and 0 is no tick.

=item string of '1' or '0'.

Where '1' means an uptick, and '0' means a downtick.

=item reference to an array of numbers

Where any positive number is an uptick, any negative number is a downtick,
and zero is no tick.

=back

=item width

This optional parameter specifies the width of the sparkline in pixels. If
the I<width> is not specified, the width of the sparkline is the value of
I<thick> times 3 times the number of I<values>.

=item thick

This optional parameter specifies the thickness of the individual whiskers
on the whisker chart. The gaps between the whiskers is twice the value of
I<thick>. This parameter is ignored if the I<width> parameter is specified.
If neither I<width> or I<thick> are specified, the default value of I<thick>
is 1.

=item color

This optional parameter specifies the color of the individual whiskers as a
SVG supported color string. The default value for this parameter is I<#000>
(black).

=back

=head2 to_string

Convert the L<SVG::Sparkline> object to an XML string.

=head1 DIAGNOSTICS

Diagnostic message for the various types are documented in the appropriate
F<SVG::Sparkline::*> module.

=head1 CONFIGURATION AND ENVIRONMENT

SVG::Sparkline requires no configuration files or environment variables.

=head1 DEPENDENCIES

L<Carp>, L<SVG>.

=head1 INCOMPATIBILITIES

None reported.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-svg-sparkline@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.

=head1 FUTURE DIRECTIONS

I plan to support more optional features and more I<intelligence> so that
the module can do a better job without you specifying everything.

=head1 AUTHOR

G. Wade Johnson  C<< <wade@anomaly.org> >>

=head1 LICENCE AND COPYRIGHT

Copyright (c) 2009, G. Wade Johnson C<< <wade@anomaly.org> >>. All rights reserved.

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
