use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'SVG::Sparkline',
    AUTHOR              => 'G. Wade Johnson <gwadej@cpan.org>',
    VERSION_FROM        => 'lib/SVG/Sparkline.pm',
    ABSTRACT_FROM       => 'lib/SVG/Sparkline.pm',
    LICENSE             => 'perl',
    EXE_FILES           => ['bin/sparkline.pl', 'bin/sparkline.cgi'],
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'Carp'       => 0,
        'SVG'        => 2.50,
        'Getopt::Long' => 0,
        'Pod::Usage'   => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'SVG-Sparkline-*' },
    META_MERGE  => {
        recommends => {
#            'Test::Pod::Coverage' => 1.04,
        },
        build_requires => {
            'Test::More' => 0,  # For testing
        },
        resources => {
            license => 'http://dev.perl.org/licenses/',
            homepage => 'http://wiki.github.com/gwadej/svg-sparkline',
            bugtracker => 'https://rt.cpan.org/Public/Dist/Display.html?Name=SVG-Sparkline',
            repository => 'https://github.com/gwadej/svg-sparkline',
#            MailingList => 'http://groups.google.com/group/svg-sparkline',
        },
    },
);
