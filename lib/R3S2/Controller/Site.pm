package R3S2::Controller::Site;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

R3S2::Controller::Site - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->detach('flisol');
}

sub flisol : Local {
    my ( $self, $c ) = @_;
    $c->stash->{sedes} = [$c->model('DB::Sede')->search({},{order_by => { -asc=> 'ciudad'}})];
    $c->stash->{template} = 'site/flisol.tt2';
}


sub admin :Chained('/') :PathPart('admin') :Args(0) {
    my ( $self, $c ) = @_;
    $c->response->redirect($c->uri_for('/admin/inicio'));
    
}


sub inicio :Chained('/admin') :PathPart('inicio') :Args(0) {
     my ( $self, $c ) = @_;
     
    if ($c->check_user_roles('admin')) {
        my $inscritos = $c->model('DB::Inscrito')->search(undef);
        $c->stash->{tot_inscritos} = $inscritos->count;
        $c->stash->{template} = 'site/admin.tt2';
    }
    if ($c->check_user_roles('coordinador')) {
        my $sede_id = $c->user->sedes->first->id;
        $c->response->redirect($c->uri_for('/admin/sede/id', $sede_id,'detalle'));
    }
}

=head1 AUTHOR

Christian Sánchez,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
