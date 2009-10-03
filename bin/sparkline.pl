#!/usr/bin/env perl

use strict;
use warnings;

use SVG::Sparkline;
use Getopt::Long;

my $type = shift;

my %options;
my $outfile;
my $clobber;
GetOptions(
    'nodecl' => \$options{'-nodecl'},
    'allns' => \$options{'-allns'},
    'sized' => \$options{'-sized'},
    'bgcolor|bg=s' => \$options{'bgcolor'},
    'padx=f' => \$options{'padx'},
    'pady=f' => \$options{'pady'},
    'height|h=f' => \$options{'height'},
    'width|w=f' => \$options{'width'},
    'values|data|v=s@' => \$options{'values'},
    'mark=s@' => \$options{'mark'},
    'color=s' => \$options{'color'},
    'xscale=f' => \$options{'xscale'},
    'thick=f' => \$options{'thick'},
    'gap=f' => \$options{'gap'},
    'outfile|o=s' => \$options{'outfile'},
    'clobber|c' => \$options{'clobber'},
) or usage();

my %params;
foreach my $key (keys %options)
{
    $params{$key} = $options{$key} if defined $options{$key};
}
unless(1 == @{$params{'values'}})
{
    print "
    $params{'values'} = [ split ',', $params{'values'}[0] ];
}
use Data::Dumper;
print Dumper( \%params );
exit;
my $svg = SVG::Sparkline->new( $type => \%params );

my $fh = \*STDOUT;
if( defined $options{'outfile'} )
{
    my ($outfile,$clobber) = @options{'outfile','clobber'};

    die "Output file '$outfile' exists, failing.\n" if !$clobber and -e $outfile;
    open( $fh, '>', $outfile ) or die "Unable to create '$outfile': $!\n";
}

print $fh "$svg";

close $fh;


sub usage
{
    print <<'EOF';
    Need to put a usage message in here.
EOF
    exit;
}

__END__
=head1 NAME

sparkline.pl - Command line tool for creating sparklines

=head1 VERSION

This document describes sparkline.pl version 0.03


=head1 USAGE

    sparkline.pl {type} [options]

=head1 DESCRIPTION

This program creates sparklines from a command line.

=head1 OPTIONS 


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
  
ModName requires no configuration files or environment variables.


=head1 DEPENDENCIES

=for author to fill in:
    A list of all the other modules that this module relies upon,
    including any restrictions on versions, and an indication whether
    the module is part of the standard Perl distribution, part of the
    module's distribution, or must be installed separately. ]

None.


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

=head1 AUTHOR

G. Wade Johnson  C<< wade@anomaly.org >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) <YEAR>, G. Wade Johnson C<< wade@anomaly.org >>. All rights reserved.

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
