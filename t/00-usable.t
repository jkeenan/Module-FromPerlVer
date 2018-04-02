use 5.008;
use lib qw( lib t/lib );

use Test::More;
use Archive::Tar;
use File::Basename  qw( basename );

use Cwd qw( getcwd );

use lib( "$Bin/../../lib", "$Bin/../lib" );
use Test::KwikHaks;

*output     = Test::KwikHaks->can( 'output' );

for my $madness
(
    qw
    (
        Test::KwikHaks
        Module::FromPerlVer::Util
        Module::FromPerlVer::Extract
        Module::FromPerlVer::Dir
        Module::FromPerlVer::Git
        Module::FromPerlVer
    )
)
{
    require_ok $madness
    or BAIL_OUT "$madness is not usable.";

    # simple check: is there any method to the madness?
    # true => package is probably spelled correctly.

    ok $madness->can( 'VERSION' ), "$madness can 'VERSION'"
    or BAIL_OUT "$madness cannot 'VERSION'", 1;

    my $ver = $madness->VERSION;
    ok $ver, "$madness has VERSION '$ver'";

    diag "Version: '$madness', $ver";
}

eval
{
    test_git_version
}
or do
{
    fail 'No git version.';
    diag "No git version: $@";
};

-e $_ or BAIL_OUT "Botched distro: missing '$_'."
for qw( version sandbox sandbox/git.tar );

done_testing;
__END__
