package SVG::Sparkline;

use warnings;
use strict;
use Carp;
use SVG;

our $VERSION = '0.0.3';

sub new
{
    my ($class, $type, $args) = @_;
    croak "No Sparkline type specified.\n" unless defined $type;
    # Use eval to load plugin.
    eval "use SVG::Sparkline::$type;";  ## no critic (ProhibitStringyEval)
    croak "Unrecognized Sparkline type '$type'.\n" if $@;
    croak "Missing arguments hash.\n" unless defined $args;
    croak "Arguments not supplied as a hash reference.\n" unless 'HASH' eq ref $args;
    croak "Missing required 'y' argument.\n" unless exists $args->{y} and defined $args->{y};

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

sub _svg
{
    return SVG->new(
        -inline=>1, -nocredits=>1, -raiseerror=>1, -indent=>'', -elsep=>'',
        @_
    );
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

=head2 CVG::Sparkline->new( $type, $args_hr )

Create a new L<SVG::Sparkline> object of the specified type, using the
parameters in the C<$args_hr> hash reference.

=head2 to_string

Convert the L<SVG::Sparkline> object to an XML string.

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
