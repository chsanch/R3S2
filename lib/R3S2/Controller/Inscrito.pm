package R3S2::Controller::Inscrito;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

R3S2::Controller::Inscrito - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched R3S2::Controller::Inscrito in Inscrito.');
}


=head1 AUTHOR

Christian Sánchez,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
