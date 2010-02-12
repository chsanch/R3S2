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
        $c->stash->{ponente} = $ponente;
        $c->forward('envia_not');
        $c->flash->{status_msg} = 'Tu propuesta de ponencia para esta sede ha sido agregada. Muchas Gracias.';
        $c->response->redirect($c->uri_for('/sedes/ver',$c->stash->{sede}->id));
        $c->detach;
    }
    else {
        $c->stash->{template} = 'ponencias/agrega.tt2';
    }
}

sub ver :Local {
    my ( $self, $c, $ponente_id) = @_;
    
    # Se busca el registro en la base de datos
    my $ponencia =  $c->model('DB::Ponente')->find($ponente_id);

    if (!$ponencia) {
        $c->stash->{resultado} = 'Registro no encontrado';
        $c->go('R3S2::Controller::Root', 'resultado');
    }
    
    $c->stash->{ponencia} = $ponencia;
    $c->stash->{template} = 'ponencias/ver.tt2';
}


#administracion

sub base :Chained('/admin') :PathPart('ponencia') :CaptureArgs(0) {
        my ($self, $c) = @_;
    
        # Almacenamos el objeto para que esté disponible en otros métodos
        $c->stash->{resultset} = $c->model('DB::Ponente');
    
}

sub objeto :Chained('base') :PathPart('id') :CaptureArgs(1) {
        #obtenemos el id del objeto
        my ($self, $c, $id) = @_;
    
        # Se busca el registro en la base de datos
        $c->stash(objeto => $c->stash->{resultset}->find($id));
    
        if (!$c->stash->{objeto}) {
            $c->stash->{resultado} = 'Registro no encontrado';
            $c->go('R3S2::Controller::Root', 'resultado');
        }
    
}

sub ponentes :Chained('/admin') :PathPart('ponentes') :Args(0) {
    my ( $self, $c ) = @_;
    if ($c->check_user_roles('admin')) {
        $c->stash->{sedes} = [$c->model('DB::Sede')->all];
        $c->stash->{template} = 'ponencias/lista.tt2';
    }
    
}

sub lista :Chained('/admin') :PathPart('ponentes/lista') :Args(1) {
    my ( $self, $c, $sede_id) = @_;
        $c->stash->{sede} = $c->model('DB::Sede')->find($sede_id);
        $c->stash->{ponencias} = [$c->model('DB::Ponente')->ponencias_aceptadas($sede_id)];
        $c->stash->{ponenciasprop} = [$c->model('DB::Ponente')->ponencias_propuestas($sede_id)];
        $c->stash->{template} = 'ponencias/listasede.tt2';
        $c->detach;
    
}

sub detalle :Chained('objeto') :PathPart('detalle') :Args(0) {
    my ( $self, $c ) = @_;
    
    $c->stash->{ponencia} = $c->stash->{objeto};
    $c->stash->{template} = 'ponencias/detalle.tt2';
}

sub aceptar :Chained('objeto') :PathPart('aceptar') :Args(0) {
        my ($self, $c) = @_;
    
        # Se borra el registro que tenemos en "objeto"
        my $ponencia = $c->stash->{objeto};
        $ponencia->aceptada('1');
        $ponencia->update;
        my $sede_id = $ponencia->sede->id;
    
        # Mensaje de confirmación
        $c->flash->{status_msg} = "Se acepto la ponencia para esta sede.";
    
        #Redirigimos a lista
        $c->response->redirect($c->uri_for('/admin/ponentes/lista',$sede_id));
}


sub cancelar :Chained('objeto') :PathPart('cancelar') :Args(0) {
        my ($self, $c) = @_;
    
        # Se borra el registro que tenemos en "objeto"
        my $ponencia = $c->stash->{objeto};
        $ponencia->aceptada('0');
        $ponencia->update;
        my $sede_id = $ponencia->sede->id;
    
        # Mensaje de confirmación
        $c->flash->{status_msg} = "La ponencia se ha cancelado para esta sede.";
    
        #Redirigimos a lista
        $c->response->redirect($c->uri_for('/admin/ponentes/lista',$sede_id));
}

=head2 envia_not
    Envia notificacion por correo cuando se crea un registro
=cut

sub envia_not : Private {
        my ( $self, $c ) = @_;
        my $sede = $c->stash->{sede}->ciudad;
        my $nompon = $c->stash->{ponente}->nombres;
        my $apellpon = $c->stash->{ponente}->apellidos;
        my $titpon = $c->stash->{ponente}->titulo_ponencia;
        my $mailpon = $c->stash->{ponente}->email;
        my $subject = "Propuesta de ponencia para la sede $sede del Flisol 2010";
        my $msj = "Se ha creado un registro para la ponencia $titpon de $nompon $apellpon en la sede $sede.\n
        Muchas gracias por tu participación, te estaremos avisando sobre el estatus de tu ponencia.\n\n
        Flisol 2010.
        ";

        $c->stash->{envia_email} = {
            to      => $mailpon,
            cc      =>  join ',', qw/registro@flisol.org.ve flisolcaracas@gmail.com/,
            bcc     =>  'flisolcaracas@gmail.com',
            from    => 'Registro Flisol 2010 <registro@flisol.org.ve>',
            subject => $subject ,
            body    => $msj,
        };

        $c->forward( $c->view('Email') );
    }



=head1 AUTHOR

Christian Sánchez,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
