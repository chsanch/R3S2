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


sub inscritos :Chained('/admin') :PathPart('inscritos') :Args(0) {
    my ( $self, $c ) = @_;
    if ($c->check_user_roles('admin')) {
        $c->stash->{sedes} = [$c->model('DB::Sede')->all];
        $c->stash->{template} = 'inscritos/lista.tt2';
        $c->detach;
    }
    if($c->check_user_roles('coordinador')){
        my $sede_id = $c->user->sedes->first->sede_id;
        $c->response->redirect($c->uri_for('/admin/inscritos/lista', $sede_id));
    }
    
}


sub lista :Chained('/admin') :PathPart('inscritos/lista') :Args(1) {
    my ( $self, $c, $sede_id) = @_;
    
        $c->stash->{sede} = $c->model('DB::Sede')->find($sede_id);
        $c->stash->{template} = 'inscritos/listasede.tt2';
        $c->detach;
    
}


sub agrega :Chained('/sede') :PathPart('agrega') :Args(0) :FormConfig {
    my ( $self, $c ) = @_;

    my $form = $c->stash->{form};
    if ( $form->submitted_and_valid ) {
        my $inscrito = $c->model('DB::Inscrito')->new_result({});
        $inscrito->sede($c->stash->{sede}->id);
        $form->model->update($inscrito);
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

=head1 AUTHOR

Christian Sánchez

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

