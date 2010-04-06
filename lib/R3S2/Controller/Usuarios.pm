package R3S2::Controller::Usuarios;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

R3S2::Controller::Usuarios - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

   $c->response->redirect($c->uri_for('/admin/usuarios/lista'));
}


sub lista :Chained('/admin') :PathPart('usuarios/lista') :Args(0) {
    my ( $self, $c ) = @_;
    if ($c->check_user_roles('admin')) {
        $c->stash->{coordinadores} = [$c->model('DB::UsuarioRol')->search( rol_id => '2') ];
        $c->stash->{instaladores} = [$c->model('DB::UsuarioRol')->search( rol_id => '3' ) ];
        $c->stash->{template} = 'usuarios/lista.tt2';
    }
    if($c->check_user_roles('coordinador')){
        $c->response->redirect($c->uri_for('/admin'));
    }
}

sub perfil :Chained('/admin') :PathPart('usuarios/perfil') :Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'usuarios/perfil.tt2';
}


=head1 AUTHOR

Christian Sánchez

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

