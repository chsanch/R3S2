package R3S2::Controller::Login;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

R3S2::Controller::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    
    # Get the username and password from form
    my $username = $c->request->params->{username};
    my $password = $c->request->params->{password};
    
    # If the username and password values were found in form
    if (defined($username) && defined($password)) {
        # Attempt to log the user in
        if ($c->authenticate({ username => $username,
                               password => $password  } )) {
            #obtenemos la pagina desde donde estamos referenciando
            my $referer = $c->req->referer;
            #dirigimos la salida a esa página
            $c->response->redirect($referer);
            return;
        } else {
            # Mensaje de error
            $c->stash->{error_msg} = "Nombre de usuario o password incorrectos.";
        }
    }

    # If either of above don't work out, send to the login page
    $c->stash->{template} = 'login.tt2';

}


=head1 AUTHOR

Christian Sánchez,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
