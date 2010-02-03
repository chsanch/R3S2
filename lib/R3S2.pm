package R3S2;

use strict;
use warnings;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use parent qw/Catalyst/;
use Catalyst qw/-Debug
                ConfigLoader
                Static::Simple
                Authentication
                Authorization::Roles 
                Session
                Session::Store::FastMmap
                Session::State::Cookie
                I18N
                Unicode
                /;
our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in r3s2.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config( name => 'Flisol 2010' );
__PACKAGE__->config->{default_view} = 'TT';
__PACKAGE__->config( 
    'View::TT' => { 
        INCLUDE_PATH =>  
        __PACKAGE__->path_to('root','templates'), 
        WRAPPER => 'includes/wrapper.tt2',
        ENCODING => 'UTF-8',
    } 
);

__PACKAGE__->config(
        name    => 'MyApp',
        session => {flash_to_stash => 1},
);

 __PACKAGE__->config->{authentication} = 
                    {  
                        default_realm => 'usuarios',
                        realms => {
                            usuarios => {
                                credential => {
                                    class => 'Password',
                                    password_field => 'password',
                                    password_type => 'self_check',
                            #        password_hash_type => 'SHA-1'                              
                                },
                                store => {
                                    class => 'DBIx::Class',
                                    user_model => 'DB::Usuario',
                                    role_relation => 'roles',
                                    role_field => 'nombre',     
                                }
                                }
                        }
                    };
    
# Start the application
__PACKAGE__->setup();


=head1 NAME

R3S2 - Catalyst based application

=head1 SYNOPSIS

    script/r3s2_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<R3S2::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Christian Sánchez,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
