#!/usr/bin/env perl

use strict;
use warnings;

use SVG::Sparkline;
use CGI;

my $q = CGI->new;
my $type = $q->param('type');
unless( length $type ) 
{
    print $q->header(-status => 400 ),
          $q->start_html( 'Input error' ),
          $q->h2( 'No sparkline type supplied' ),
          $q->end_html;
    exit 0;
}

my $svg = eval { SVG::Sparkline->new( $type => parameters_from_query( $q ) ); };
if( defined $svg )
{
    print $q->header('image/svg+xml'), $svg->to_string();
}
else
{
    print $q->header(-status => 400 ),
          $q->start_html( 'Input error' ),
          $q->h2( 'Error creating sparkline' ),
          $q->p( $q->strong( $@ || 'Invalid input parameters' ) ),
          $q->end_html;
}

exit 0;

#
# Convert query parameters into apropriate parameters for the
# SVG::Sparkline constructor.
sub parameters_from_query
{
    my ($q) = @_;
    my %params;
    foreach my $key ( $q->param )
    {
        my @value = $q->param( $key );
        if( $key eq 'sized' )
        {
            $params{'-sized'} = $value[0] || 0;
        }
        elsif( $key eq 'nodecl' or $key eq 'allns' ) {
            $params{"-$key"} = $value[0];
        }
        elsif( $key eq 'mark' )
        {
            $params{$key} = [ @value ];
        }
        elsif( length $value[0] )
        {
            $params{$key} = $value[0];
        }
    }
    # Clean up values parameter

    $params{'values'} =~ tr/ /+/ if $params{'values'} =~ /^[- 0]+$/;
    $params{'values'} = [ split ',', $params{'values'} ]
        unless 'Whisker' eq $type && $params{'values'} =~ /^[-+0]+$/;
    $params{'values'} = [ map { [ split ':', $_ ] } @{$params{'values'}} ]
        if $type eq 'RangeArea' or $type eq 'RangeBar';

    # Clean up mark parameter
    $params{'mark'} = [ map { split /[=:]/, $_ } @{$params{'mark'}} ];

    return \%params;
}

__END__
=head1 NAME

sparkline.cgi - CGI script for generating sparklines

=head1 VERSION

This document describes sparkline.cgi version 0.32

=head1 Synopsis

    http://example.com/sparkline.cgi?type=Line&sized=0&nodecl=1&values=1,2,3,4,5

=head1 DESCRIPTION

Since SVG sparklines are useful for display on the web, this CGI script supports
creating sparklines on the fly. The CGI returns an SVG file representing the
sparkline based on the supplied parameters.

=head1 QUERY PARAMETERS

=over 4

=item type

The value of this parameter specifies the type of sparkline. It must be one of
C<Area>, C<Bar>, C<Line>, C<RangeArea>, C<RangeBar>, or C<Whisker>.

=item nodecl

A value of 1 removes the XML declaration from the beginning of the SVG output.

=item allns

A value of 1 provides all of the xmlns attributes on the root svg element, the
default is to only supply the default SVG namespace.

=item sized

A value of 1 adds the I<height> and I<width> attributes on the root svg element. This is
currently the default behavior. A value of 0 removes thos attributes.

=item bgcolor={color}

Specify a background color for the sparkline. By default, the sparkline will
have a transparent background.

=item padx={length}

Provide {length} pixels of padding on the left and right of the sparkline.

=item pady={length}

Provide {length} pixels of padding on the top and bottom of the sparkline.

=item height={length}

Specify the height of the sparkline. The default height is 10 pixels.

=item width={length}

Specify the width of the sparkling in pixels. The default width depends on the
sparkline type and the number of data values.

=item values={comma separated list of values}

Specify the parameters to display on the sparkline. These values can take one
of three forms.

=over 4

=item All but RangeArea and RangeBar

Almost all sparkline types support the default data format which is a series
of numbers separated by commas. The C<Whisker> type has limits on the values
allowed. Other than that, all specified types work the same way.

  values=1,2,3,4,5,6,7,8,9

=item Whisker

The C<Whisker> sparkline type supports another format which is more condensed.
This is a series of '+', '-', and '0' characters that represent the high, low,
and neutral ticks on the Whisker graph.

   values=+--+-0+---+++

=item RangeArea and RangeBar

These two sparkline types require a pair of data values for each point on the
sparkline. To accomplish this, we comma-separated list of pairs of values. Each
pair consists of two values separated by a colon, with the smaller value first.

   values=1:1,2:4,3:9,4:16,5:25

=back

=item mark={mark}

This parameter can be supplied multiple times to define multiple marks. Each mark
has an index value and a color separated by a colon (or equals). The index value
can be either a numeric index or one of the named indexes described in
L<SVG::Sparkline::Manual> under I<mark>.

=item color={color}

Specify the color of the data line.

=item xscale={length}

Specify the distance between individual data points in the absence of a
a I<width>. If neither I<width> or I<xscale> are supplied, the default
is 2.

=item thick={length}

Thickness of the line for those sparklines that have lines. For a Bar or
RangeBar sparkline, this specifies the thickness of the bar.

=item gap={length}

Gap between the bars of the Bar sparkline or the whiskers of the
Whisker sparkline.

=back

=head1 CONFIGURATION AND ENVIRONMENT

sparkline.pl requires no configuration files or environment variables.

=head1 DEPENDENCIES

L<SVG::Sparkline>, L<Getopt::Long>, and L<Pod::Usage>.

=head1 INCOMPATIBILITIES

None reported.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

=head1 AUTHOR

G. Wade Johnson  C<< wade@anomaly.org >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2009, G. Wade Johnson C<< wade@anomaly.org >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl 5.10.0 itself. See L<perlartistic>.


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
