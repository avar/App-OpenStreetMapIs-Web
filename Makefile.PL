#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install;

name 'App-OpenStreetMapIs-Web';
all_from 'lib/App/OpenStreetMapIs/Web.pm';

requires 'Catalyst::Runtime' => '5.80015';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Catalyst::Plugin::I18N';
requires 'Catalyst::Plugin::Unicode';
requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
test_requires 'Test::More' => '0.88';
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
