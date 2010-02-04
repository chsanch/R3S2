package R3S2::Schema::ResultSet::Ponente;

use strict;
use warnings;
 use base 'DBIx::Class::ResultSet';


=head2 ponencias_aceptadas
     Funcion para obtener solo las ponencias aceptadas para una sede
=cut

sub ponencias_aceptadas {
    my ($self, $sede) = @_;
    return $self->search({
        sede => { '=' => $sede},
        aceptada => { '=' => '1'}
    })
}


sub ponencias_propuestas {
    my ($self, $sede) = @_;
    return $self->search({
        sede => { '=' => $sede},
        aceptada => { '=' => '0'}
    })
}


1;
