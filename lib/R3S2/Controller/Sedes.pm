package R3S2::Controller::Sedes;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller::HTML::FormFu'; }

=head1 NAME

R3S2::Controller::Sedes - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->response->redirect($c->uri_for($self->action_for('lista')));
    $c->detach;
}

sub lista : Local {
    my ( $self, $c ) = @_;
    $c->stash->{sedes} = [$c->model('DB::Sede')->all];
    $c->stash->{template} = 'sedes/lista.tt2';
}


sub base :Chained('/admin') :PathPart('sede') :CaptureArgs(0) {
        my ($self, $c) = @_;
    
        # Almacenamos el objeto para que esté disponible en otros métodos
        $c->stash->{resultset} = $c->model('DB::Sede');
    
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
        my $sede = $c->model('DB::Sede')->new_result({});
        $form->model->update($sede);
        $c->stash->{status_msg} = 'Sede Creada';
        $c->response->redirect($c->uri_for($self->action_for('lista')));
        $c->detach;
    }
    else {
    	my @distros;
        foreach ($c->model('DB::Distro')->all) {
            push(@distros,[$_->id,$_->nombre])
        }
        my $distrosel = $form->get_element({ name => 'distros'});
        $distrosel->options(\@distros);
        $c->stash->{template} = 'sedes/agrega.tt2';
    }
}


sub ver : Local {
    my ( $self, $c, $sede_id ) = @_;
    $c->stash->{sede} = $c->model('DB::Sede')->find($sede_id);
    $c->stash->{template} = 'sedes/ver.tt2';
}



sub detalle :Chained('/sede') :PathPart('detalle') :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash->{sede} = $c->model('DB::Sede')->find($c->stash->{sede}->id);
    $c->stash->{template} = 'sedes/ver.tt2';
}


sub sede :Chained('/') :PathPart('sede') :Args(1) {
    my ( $self, $c, $sede_id) = @_;

    my $sede = $c->model('DB::Sede')->find($sede_id);
    $c->stash->{sede} = $sede;
    $c->stash->{template} = 'sedes/ver.tt2';
}
=head1 AUTHOR

Christian Sánchez

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

