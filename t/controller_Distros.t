use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'R3S2' }
BEGIN { use_ok 'R3S2::Controller::Distros' }

ok( request('/distros')->is_success, 'Request should succeed' );
done_testing();
