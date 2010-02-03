package R3S2::Controller::Distros;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller::HTML::FormFu'; }

=head1 NAME

R3S2::Controller::Distros - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->redirect($c->uri_for('/admin/distros/lista'));
}

sub lista :Chained('/admin') :PathPart('distros/lista') :Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{distros} = [$c->model('DB::Distro')->all];
    $c->stash->{template} = 'distros/lista.tt2';
}

sub base :Chained('/admin') :PathPart('distro') :CaptureArgs(0) {
        my ($self, $c) = @_;
    
        # Almacenamos el objeto para que esté disponible en otros métodos
        $c->stash->{resultset} = $c->model('DB::Distro');
    
}

sub objeto :Chained('base') :PathPart('id') :CaptureArgs(1) {
        #obtenemos el id del objeto
        my ($self, $c, $id) = @_;
    
        # Se busca el registro en la base de datos
        $c->stash(objeto => $c->stash->{resultset}->find($id));
    
        if (!$c->stash->{objeto}) {
            $c->stash->{resultado} = 'Registro no encotrado';
            $c->go('R3S2::Controller::Root', 'resultado');
        }
    
}

sub agrega :Chained('base') :PathPart('agrega') :Args(0) :FormConfig {
    my ($self, $c) = @_;
    my $form = $c->stash->{form};
    if ( $form->submitted_and_valid ) {
        my $distro = $c->model('DB::Distro')->new_result({});
        $form->model->update($distro);
        $c->flash->{status_msg} = 'Distro Agregada';
        $c->response->redirect($c->uri_for($self->action_for('lista')));
        $c->detach;
    }
    else {
        $c->stash->{template} = 'distros/agrega.tt2';
    }
}

sub editar :Chained('objeto') :PathPart('editar') :Args(0) :FormConfig('distros/agrega.yml') {
    my ($self, $c) = @_;
    my $distro = $c->stash->{objeto};
    
    unless ($distro) {
            $c->flash->{error_msg} = "Registros No Valido";
            $c->response->redirect($c->uri_for($self->action_for('lista')));
            $c->detach;
        }
    
    my $form = $c->stash->{form};
    
    if ( $form->submitted_and_valid ) {
        $form->model->update($distro);
        $c->flash->{status_msg} = 'Registro Modificado';
        $c->response->redirect($c->uri_for($self->action_for('lista')));
        $c->detach;
    }
    else {
        $form->model->default_values($distro);
        $c->stash->{template} = 'distros/agrega.tt2';
    }
}

sub eliminar :Chained('objeto') :PathPart('eliminar') :Args(0) {
        my ($self, $c) = @_;
    
        # Se borra el registro que tenemos en "objeto"
        $c->stash->{objeto}->delete;
    
        # Mensaje de confirmación
        $c->flash->{status_msg} = "Se elimin&oacute; el registro.";
    
        #Redirigimos a lista
        $c->response->redirect($c->uri_for($self->action_for('lista')));
}

=head1 AUTHOR

Christian Sánchez

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

