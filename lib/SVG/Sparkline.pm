package SVG::Sparkline;

use warnings;
use strict;
use Carp;
use SVG;

use overload  '""' => \&to_string;

use 5.008000;
our $VERSION = '0.2.7';

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
        -nodecl => 0,
        -allns => 0,
        color => '#000',
        %{$args},
    }, $class;

    $self->_validate_pos_param( 'height', 12 );
    $self->_validate_pos_param( 'width', 0 );
    $self->_validate_pos_param( 'xscale' );
    $self->_validate_pos_param( 'yscale' );
    $self->_validate_nonneg_param( 'pady', 1 );
    $self->_validate_nonneg_param( 'padx', 0 );
    $self->_validate_mark_param();
    foreach my $arg (qw/color bgcolor/)
    {
        next unless exists $self->{$arg};
        croak "The value of $arg is not a valid color.\n"
            unless _is_color( $self->{$arg} );
    }

    $self->{xoff} = -$self->{padx};
    $self->_make( $type );

    return $self;
}

sub get_height { return $_[0]->{height}; }
sub get_width { return $_[0]->{width}; }

sub to_string
{
    my ($self) = @_;
    my $str = $self->{_SVG}->xmlify();
    # Cleanup
    $str =~ s/ xmlns:(?:svg|xlink)="[^"]+"//g unless $self->{'-allns'};
    $str =~ s/<\?[^\?]+\?>// if $self->{'-nodecl'};
    return $str;
}

sub _make
{
    my ($self, $type) = @_;
    # Disable strict to allow calling method from plugin.
    no strict 'refs'; ## no critic (ProhibitNoStrict)
    $self->{_SVG} = "SVG::Sparkline::$type"->make( $self );
    return;
}

sub _validate_pos_param
{
    my ($self, $name, $default) = @_;
    croak "'$name' must have a positive numeric value.\n"
        if exists $self->{$name} && $self->{$name} <= 0;
    return if exists $self->{$name};

    $self->{$name} = $default if defined $default;
    return;
}

sub _validate_nonneg_param
{
    my ($self, $name, $default) = @_;
    croak "'$name' must be a non-negative numeric value.\n"
        if exists $self->{$name} && $self->{$name} < 0;
    return if exists $self->{$name};

    $self->{$name} = $default if defined $default;
    return;
}

sub _validate_mark_param
{
    my ($self) = @_;

    return unless exists $self->{mark};

    croak "'mark' parameter must be an array reference.\n"
        unless 'ARRAY' eq ref $self->{mark};
    croak "'mark' array parameter must have an even number of elements.\n"
        unless 0 == (@{$self->{mark}}%2);

    my @marks = @{$self->{mark}};
    while(@marks)
    {
        my ($index, $color) = splice( @marks, 0, 2 );
        croak "'$index' is not a valid mark index.\n"
            unless $index =~ /^(?:first|last|high|low|\d+)$/;
        croak "'$color' is not a valid mark color.\n"
            unless _is_color( $color );
    }
    return;
}

sub _is_color
{
    my ($color) = @_;
    return 1 if $color =~ /^#[[:xdigit:]]{3}$/;
    return 1 if $color =~ /^#[[:xdigit:]]{6}$/;
    return 1 if $color =~ /^rgb\(\d+,\d+,\d+\)$/;
    return 1 if $color =~ /^rgb\(\d+%,\d+%,\d+%\)$/;
    return 1 if $color =~ /^[[:alpha:]]+$/;
    return;
}

1; # Magic true value required at end of module
__END__

=head1 NAME

SVG::Sparkline - Create Sparklines in SVG


=head1 VERSION

This document describes SVG::Sparkline version 0.2.5

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

=head2 SVG::Sparkline->new( $type, $args_hr )

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

=item bgcolor

The value of this parameter is an SVG-supported color string which specifies
a color for the background of the sparkline. In general, this parameter should
not be supplied or should be very subtle to avoid taking attention away from
the actual data displayed.

=item padx

The value of this parameter is the number of pixels of padding inside the
sparkline, but to the left of the first data point and right of the last
data point. 

=item pady

The value of this parameter is the number of pixels of padding inside the
sparkline, but above the highest data point and below the lowest data point.

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

=item mark

There are times when certain points on the sparkline need to be highlighted
in some way. For instance, you might want to highlight the lowest and highest
value of a data set. The C<mark> attribute supports this functionality.

The appearance of the mark is mostly determined by the sparkline type. However,
you may select different colors for each mark.

The value of the C<mark> attribute is a reference to an array of pairs, where
each pair consists of an index and a color. The index is either an integer
specifying which point in the C<values> is to be marked or a string that
describes a particular point. The supported index strings are

=over 4

=item first

This index string represents the first data point. It is synonymous with a
numeric index of 0.

=item last

This index string represents the last data point. It is equal to one less than
the number of C<values>.

=item high

This index string repesents the highest value in the data set. If there is more
than one point with the highest value, the first index with this value is
selected.

=item low

This index string repesents the lowest value in the data set. If there is more
than one point with the lowest value, the first index with this value is
selected.

=back

The following would be examples of marks:

=over 4

=item Single Indexed Mark

   mark => [ 3 => 'blue' ]

=item High and Low Marks

  mark => [ low => 'red', high => 'green' ]

=back

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

=item mark

The mark for an Area is a vertical line of the specified color. The line moves
from a value of zero up to the value.

=item xscale

This parameter determines the distance between data points. The C<width>
parameter overrides the C<xscale> parameter. If no C<width> or C<xscale>
are supplied, the default value is 2.

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

=item gap

This optional parameter specifies a gap to appear between individual bars on
the bar graph. If the I<gap> is not specified, the default value is 0.

=item width

This optional parameter specifies the width of the sparkline in pixels. If
the I<width> is not specified, the width of the sparkline is the value of
I<thick> times the number of I<values>.

=item color

This optional parameter specifies the color of the filled area between the
data line and the x-axis as a SVG supported color string. The default value
for this parameter is I<#000> (black).

=item mark

The mark for Bar replaces the bar in question with one of the specified color.

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

=item mark

The mark for Line is a dot of the specified color at the chosen location. The
radius of the dot is the same as the width of the line, specified by the
C<thick> parameter.

=item xscale

This parameter determines the distance between data points. The C<width>
parameter overrides the C<xscale> parameter. If no C<width> or C<xscale>
are supplied, the default value is 2.

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

=item gap

This optional parameter specifies a gap to appear between individual whiskers
on the whisker chart. If the I<gap> is not specified, the default value is
twice the I<thick> value for the whiskers.

=item color

This optional parameter specifies the color of the individual whiskers as a
SVG supported color string. The default value for this parameter is I<#000>
(black).

=item mark

The mark for Whisker replaces the whisker in question with one of the
specified color.

=back

=head2 get_height

Returns in height in pixels of the completed sparkline.

=head2 get_width

Returns in width in pixels of the completed sparkline.

=head2 to_string

Convert the L<SVG::Sparkline> object to an XML string. This is the method that
is used by the stringification overload.

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

=head1 ACKNOWLEDGEMENTS

This module has been greatly improved by suggestions and corrections supplied
but Robert Boone, Debbie Campbell, and Joshua Keroes.

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
