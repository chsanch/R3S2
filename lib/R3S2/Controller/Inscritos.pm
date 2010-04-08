package R3S2::Controller::Inscritos;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller::HTML::FormFu'; }

=head1 NAME

R3S2::Controller::Inscritos - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    my @sedes = $c->model('DB::Sede')->all;
    $c->stash->{sedes} = [map {{id => $_->id, ciudad => $_->ciudad}}@sedes];
    $c->stash->{template} = 'inscritos/index.tt2';

}


sub agrega :Chained('/sede') :PathPart('agrega') :Args(0) :FormConfig {
    my ( $self, $c ) = @_;

    my $form = $c->stash->{form};
    if ( $form->submitted_and_valid ) {
        my $inscrito = $c->model('DB::Inscrito')->new_result({});
        $inscrito->sede($c->stash->{sede}->id);
        $form->model->update($inscrito);
        $c->stash->{inscrito} = $inscrito;
        $c->forward('envia_not');
        $c->flash->{status_msg} = 'Te has Registrado Para esta Sede.';
        $c->response->redirect($c->uri_for('/sedes/ver',$c->stash->{sede}->id));
        $c->detach;
    }
    else {
        my @distros;
        push(@distros,['','---']);
        foreach ($c->stash->{sede}->sede_distros) {
            push(@distros,[$_->distro->id,$_->distro->nombre])
        }
        push(@distros,['','No lo se']);
        my $distrosel = $form->get_element({ name => 'distro'});
        $distrosel->options(\@distros);
        $c->stash->{template} = 'inscritos/agrega.tt2';
    }
}

#Administracion

sub lista :Chained('/admin') :PathPart('inscritos/lista') :Args(1) {
    my ( $self, $c, $sede_id) = @_;
    
    if ($c->check_user_roles('coordinador')) { $sede_id = $c->user->sedes->first->id; }   
        
    $c->stash->{sede} = $c->model('DB::Sede')->find($sede_id);
    $c->stash->{template} = 'inscritos/listasede.tt2';
    $c->detach;
    
}

sub inscritos :Chained('/admin') :PathPart('inscritos') :Args(0) {
    my ( $self, $c ) = @_;
    if ($c->check_user_roles('admin')) {
        $c->stash->{sedes} = [$c->model('DB::Sede')->all];
        $c->stash->{template} = 'inscritos/lista.tt2';
        $c->detach;
    }
    if($c->check_user_roles('coordinador')){
        my $sede_id = $c->user->sedes->first->id;
        $c->response->redirect($c->uri_for('/admin/inscritos/lista', $sede_id));
    }
    
}


sub base :Chained('/admin') :PathPart('inscrito') :CaptureArgs(0) {
        my ($self, $c) = @_;
    
        # Almacenamos el objeto para que esté disponible en otros métodos
        $c->stash->{resultset} = $c->model('DB::Inscrito');
    
}

sub objeto :Chained('base') :PathPart('id') :CaptureArgs(1) {
        #obtenemos el id del objeto
        my ($self, $c, $id) = @_;
    
        # Se busca el registro en la base de datos
        my $ponencia = $c->stash->{resultset}->find($id);
        $c->stash( objeto => $ponencia );
        
        if($c->check_user_roles('coordinador')){
           my $sede_id = $c->user->sedes->first->id;
           if ((!$c->stash->{objeto}) || ( $ponencia->sede->id != $sede_id )) {
                $c->stash->{resultado} = "Registro no encontrado";
                $c->go('R3S2::Controller::Root', 'resultado');
            }
        }
        if($c->check_user_roles('admin')){
            if (!$c->stash->{objeto}) {
                $c->stash->{resultado} = "Registro no encontrado";
                $c->go('R3S2::Controller::Root', 'resultado');
            }
        }
    
}


sub eliminar :Chained('objeto') :PathPart('eliminar') :Args(0) {
    my ($self, $c) = @_;

        # obtenemos el id de la sede 
        my $sede_id = $c->stash->{objeto}->sede->id;
        
        # Se borra el registro que tenemos en "objeto"       
        $c->stash->{objeto}->delete;        
    
        # Mensaje de confirmación
        $c->flash->{status_msg} = "Se elimin&oacute; el registro.";
    
        #Redirigimos a lista
        $c->response->redirect($c->uri_for('/admin/inscritos/lista', $sede_id));
}

#detalle del inscrito
sub detalle :Chained('objeto') :PathPart('detalle') :Args(0) {
    my ( $self, $c ) = @_;
    
    $c->stash->{inscrito} = $c->stash->{objeto};
    $c->stash->{template} = 'inscritos/detalle.tt2';
}


=head2 envia_not
    Envia notificacion por correo cuando se crea un registro
=cut


sub envia_not : Private {
        my ( $self, $c ) = @_;
        my $sede = $c->stash->{sede}->ciudad;
        my $nomins = $c->stash->{inscrito}->nombres;
        my $apellins = $c->stash->{inscrito}->apellidos;
        my $mailins = $c->stash->{inscrito}->email;
        my $subject = "Registro para la sede $sede del Flisol 2010";
        my $msj = "Se ha creado un registro para $nomins $apellins en la sede $sede.\n
        Muchas gracias por tu participación\n\n
        Flisol 2010.
        ";

        $c->stash->{envia_email} = {
            to      => $mailins,
            cc      =>   'registro@flisol.org.ve',
            bcc     =>  'flisolcaracas@gmail.com',
            from    => 'Registro Flisol 2010 <registro@flisol.org.ve>',
            subject => $subject ,
            body    => $msj,
        };

        $c->forward( $c->view('Email') );
    }

=head1 AUTHOR

Christian Sánchez

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

