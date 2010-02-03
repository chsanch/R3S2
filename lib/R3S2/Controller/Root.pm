package R3S2::Controller::Root;

use strict;
use warnings;
use parent 'Catalyst::Controller';

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config->{namespace} = '';

=head1 NAME

R3S2::Controller::Root - Root Controller for R3S2

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=cut

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->go('R3S2::Controller::Site', 'index');

}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'nofound.tt2';
    $c->response->status(404);
}


sub sede :Chained('/') :PathPart('sede') :CaptureArgs(1) {
    my ( $self, $c, $sede_id ) = @_;
    #$sede_id = $c->req->param('sede') if $sede_id == "";
    my $sede = $c->model('DB::Sede')->find($sede_id);
    $c->stash->{sede} = $sede;
}


sub admin :Chained('/') :PathPart('admin') :CaptureArgs(0){
    my ( $self, $c ) = @_;
    if (!$c->user_exists) {
            $c->log->debug('***admin: Usuario no encontrado, direccionando a /login');
            # Redireccionar a Login
            $c->go('R3S2::Controller::Login', 'index');
        }
    
    return 1;
}

sub noautorizado : Local {
	
	my ( $self, $c ) = @_;
	$c->stash->{template} = 'noaut.tt2';

}

sub resultado : Local {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'resultado.tt2';
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Christian Sánchez,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
