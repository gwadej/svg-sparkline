package SVG::Sparkline;

use warnings;
use strict;
use Carp;

our $VERSION = '0.0.3';

my %factory = (
    Whisker => \&_whisker,
);

sub new
{
    my ($class, $type, $args) = @_;
    croak "'$type' is not a valid Sparkline type.\n" unless exists $factory{$type};
    $args = {} unless defined $args;
    croak "Arguments not supplied as a hash reference.\n" unless 'HASH' eq ref $args;

    my $self = bless {
        height => 10,
        color => '#000',
    }, $class;
    
    $factory{$type}->( $self, $args );

    return $self;
}

sub _whisker
{
    my ($self, $args) = @_;

    return;
}

1; # Magic true value required at end of module
__END__

=head1 NAME

SVG::Sparkline - Create Sparklines in SVG


=head1 VERSION

This document describes SVG::Sparkline version 0.0.3


=head1 SYNOPSIS

    use SVG::Sparkline;

    my $sl1 = SVG::Sparkline->new( 'Whisker', { y=>\@values, color=>'#eee', height=>12 } );
    print $sl1->to_string();

    my $sl2 = SVG::Sparkline->new( 'Line', { y=>\@values, x=>\@x, color=>'blue', height=>12 } );
    print $sl2->to_string();

    my $sl3 = SVG::Sparkline->new( 'Area', { y=>\@values, x=>\@x, color=>'green', height=>10 } );
    print $sl3->to_string();

    my $sl4 = SVG::Sparkline->new( 'Bar', { y=>\@values, color=>'#66f', height=>10 } );
    print $sl4->to_string();
  
=head1 DESCRIPTION

In the book I<Beautiful Evidence>, Edward Tufte describes sparklines as
I<small, high-resolution, graphics embedded in a context of words, numbers, images>. 

This module provides a relatively easy interface for creating different
kinds of sparklines. This class is not intended to be used to build large,
complex graphs (there are other modules much more suited to that job). The
focus here is on the kinds of data well-suited to the sparklines concept.

=head1 INTERFACE 

=head2 new

=for author to fill in:
    Write a separate section listing the public components of the modules
    interface. These normally consist of either subroutines that may be
    exported, or methods that may be called on objects belonging to the
    classes provided by the module.


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

=for author to fill in:
    A full explanation of any configuration system(s) used by the
    module, including the names and locations of any configuration
    files, and the meaning of any environment variables or properties
    that can be set. These descriptions must also include details of any
    configuration language used.
  
SVG::Sparkline requires no configuration files or environment variables.


=head1 DEPENDENCIES

L<Carp>, L<SVG>

=head1 INCOMPATIBILITIES

=for author to fill in:
    A list of any modules that this module cannot be used in conjunction
    with. This may be due to name conflicts in the interface, or
    competition for system or program resources, or due to internal
    limitations of Perl (for example, many modules that use source code
    filters are mutually incompatible).

None reported.


=head1 BUGS AND LIMITATIONS

=for author to fill in:
    A list of known problems with the module, together with some
    indication Whether they are likely to be fixed in an upcoming
    release. Also a list of restrictions on the features the module
    does provide: data types that cannot be handled, performance issues
    and the circumstances in which they may arise, practical
    limitations on the size of data sets, special cases that are not
    (yet) handled, etc.

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-svg-sparkline@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.


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
