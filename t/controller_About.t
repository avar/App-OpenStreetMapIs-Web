use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'App::OpenStreetMapIs::Web' }
BEGIN { use_ok 'App::OpenStreetMapIs::Web::Controller::About' }

ok( request('/about')->is_success, 'Request should succeed' );
done_testing();
