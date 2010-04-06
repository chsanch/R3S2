package R3S2::Controller::Coordinadores;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller::HTML::FormFu'; }

=head1 NAME

R3S2::Controller::Coordinadores - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->response->redirect($c->uri_for('/admin/usuarios/perfil'));
}

sub base :Chained('/admin') :PathPart('coordinador') :CaptureArgs(0) {
        my ($self, $c) = @_;
    
        # Almacenamos el objeto para que esté disponible en otros métodos
        $c->stash->{resultset} = $c->model('DB::Usuario');
    
}

sub objeto :Chained('base') :PathPart('id') :CaptureArgs(1) {
        #obtenemos el id del objeto
        my ($self, $c, $id) = @_;
        if ($c->check_user_roles('coordinador')) { $id = $c->user->id; }
        # Se busca el registro en la base de datos
        $c->stash(objeto => $c->stash->{resultset}->find($id));
    
        if (!$c->stash->{objeto}) {
            $c->stash->{resultado} = 'Registro no encotrado';
            $c->go('R3S2::Controller::Root', 'resultado');
        }
    
}

sub lista :Chained('/admin') :PathPart('coordinadores/lista') :Args(0) {
    my ( $self, $c ) = @_;
    if ($c->check_user_roles('admin')) {
        $c->stash->{coordinadores} = [$c->model('DB::UsuarioRol')->search( rol_id => '2') ];
        $c->stash->{template} = 'coordinadores/lista.tt2';
    }
    if($c->check_user_roles('coordinador')){
        $c->response->redirect($c->uri_for('/admin'));
    }
}

sub agrega :Chained('base') :PathPart('agrega') :Args(0) :FormConfig {
    my ($self, $c) = @_;
    my $form = $c->stash->{form};
    
    if ($c->check_user_roles('coordinador')) {
        $c->response->redirect($c->uri_for('/admin/usuarios/perfil'));
    }
    
    if ($c->check_user_roles('admin')) {
            
        if ( $form->submitted_and_valid ) {
            my $usuario = $c->model('DB::Usuario')->new_result({});
            $form->model->update($usuario);
            my $nombre = $usuario->nombre ." ". $usuario->apellido;
            #my $sedeus = $c->req->param('sede');
            #se crea la relacion entre la sede y el usuario
            #$usuario->add_to_sedes( {sede_id => $sedeus} );
            #se crea la relacion entre el rol y el usuario
            $usuario->add_to_map_usuario_roles( {rol_id => '2'} );
            #$c->response->redirect($c->uri_for($self->action_for('index')));
            #$c->detach;
            $c->stash->{status_msg} = "Usuario Creado $nombre ";
            $c->stash->{resultado} = "Registro creado para el usuario $nombre";
            $c->go('R3S2::Controller::Root', 'resultado');
        }
        else {
            my @sedes;
            push(@sedes,['','---']);
            foreach ($c->model('DB::Sede')->search({},{order_by => { -asc=> 'ciudad'}})) {
                push(@sedes,[$_->id,$_->ciudad])
            }
            my $sedessel = $form->get_element({ name => 'sedes'});
            $sedessel->options(\@sedes);
            $c->stash->{template} = 'coordinadores/agrega.tt2';
        }
        
   }
    
}



sub editar :Chained('objeto') :PathPart('editar') :Args(0) :FormConfig('coordinadores/edita.yml') {
    my ($self, $c) = @_;
    my $usuario = $c->stash->{objeto};
    
    unless ($usuario) {
            $c->flash->{error_msg} = "Registro No Valido";
            $c->response->redirect($c->uri_for($self->action_for('lista')));
            $c->detach;
        }
    
    my $form = $c->stash->{form};
    
    if ( $form->submitted_and_valid ) {
        $form->model->update($usuario);
        $c->flash->{status_msg} = "Registro Modificado";
        
        if ($c->check_user_roles('admin')) {
            $c->response->redirect($c->uri_for('/admin/coordinadores/lista'));
        }
        if ($c->check_user_roles('coordinador')) {
            $c->response->redirect($c->uri_for('/admin/usuarios/perfil'));
        }
        $c->detach;
    }
    else {
            my @sedes;
            push(@sedes,[$usuario->sedes->first->id,$usuario->sedes->first->ciudad]);
            
            if ($c->check_user_roles('admin')) {
                foreach ($c->model('DB::Sede')->search({},{order_by => { -asc=> 'ciudad'}})) {
                    push(@sedes,[$_->id,$_->ciudad])
                }
            }
            my $sedessel = $form->get_element({ name => 'sedes'});
            $sedessel->options(\@sedes);
            $form->model->default_values($usuario);
            $c->stash->{username} = $usuario->username;
            $c->stash->{template} = 'coordinadores/agrega.tt2';
    }
}


sub password :Chained('objeto') :PathPart('password') :Args(0) :FormConfig('coordinadores/password.yml') {
    my ($self, $c) = @_;
    my $usuario = $c->stash->{objeto};
    my $form = $c->stash->{form};
    
    if ( $form->submitted_and_valid ) {
        $usuario->password($c->req->param('password'));
        $usuario->update;
        $c->flash->{status_msg} = 'Registro Modificado - Tu Password ha sido moficado';
        if ($c->check_user_roles('coordinador')) {
            $c->response->redirect($c->uri_for('/admin/usuarios/perfil'));
        }
        if ($c->check_user_roles('admin')) {
            $c->response->redirect($c->uri_for('/admin/coordinadores/lista'));
        }
        $c->detach;
    }
    else {
        $c->stash->{username} = $usuario->username;
        $c->stash->{template} = 'coordinadores/password.tt2';
    }
}

=head1 AUTHOR

Christian Sánchez

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

