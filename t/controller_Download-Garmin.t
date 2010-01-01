use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'App::OpenStreetMapIs::Web' }
BEGIN { use_ok 'App::OpenStreetMapIs::Web::Controller::Download::Garmin' }

ok( request('/download/garmin')->is_success, 'Request should succeed' );
done_testing();
