package R3S2::Controller::Ponencias;

use strict;
use warnings;
use parent 'Catalyst::Controller::HTML::FormFu';

=head1 NAME

R3S2::Controller::Ponencias - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->go('R3S2::Controller::Site', 'index');
}

sub agrega :Chained('/sede') :PathPart('agrega/ponente') :Args(0) :FormConfig {
    my ( $self, $c ) = @_;
    
    my $form = $c->stash->{form};
    if ( $form->submitted_and_valid ) {
        my $ponente = $c->model('DB::Ponente')->new_result({});
        $ponente->sede($c->stash->{sede}->id);
        $form->model->update($ponente);
        $c->stash->{status_msg} = "Registro Agregado";
        my $resultado = "Tu ponencia ha sido agregado exitosamente";
        $c->stash->{resultado} = $resultado;
        $c->stash->{template} = 'resultado.tt2';
    }
    else {
        $c->stash->{template} = 'ponencias/agrega.tt2';
    }
}


sub ponentes :Chained('/admin') :PathPart('ponentes') :Args(0) {
    my ( $self, $c ) = @_;
    if ($c->check_user_roles('admin')) {
        $c->stash->{sedes} = [$c->model('DB::Sede')->all];
        $c->stash->{template} = 'ponencias/lista.tt2';
    }
    
}

=head1 AUTHOR

Christian Sánchez,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
