#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install;

name 'R3S2';
all_from 'lib/R3S2.pm';

requires 'Catalyst::Runtime' => '5.80013';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'parent';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
requires (
        'Catalyst::Plugin::Authentication' => '0',
        'Catalyst::Plugin::Session' => '0',
        'Catalyst::Plugin::Session::Store::FastMmap' => '0',
        'Catalyst::Plugin::Session::State::Cookie' => '0',
        'DBIx::Class::EncodedColumn' => '0.00006',
        'DBIx::Class::TimeStamp' => '0.12',
        'Catalyst::View::Email' => '0.23',
        'HTML::FormFu' => '0.06001',
        'HTML::FormFu::Model::DBIC' => '0.06000'
    ); 
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
