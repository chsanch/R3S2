use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'R3S2' }
BEGIN { use_ok 'R3S2::Controller::Login' }

ok( request('/login')->is_success, 'Request should succeed' );


