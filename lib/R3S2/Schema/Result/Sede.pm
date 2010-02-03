package R3S2::Schema::Result::Sede;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "EncodedColumn", "Core");
__PACKAGE__->table("sede");
__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    default_value => "nextval('sede_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "ciudad",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "lugar",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "fecha",
  { data_type => "date", default_value => undef, is_nullable => 1, size => 4 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("id_sede", ["id"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-01-29 00:04:25
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:8o+S8EpFOB65+8wXr0hI4g

#Relaciones 

__PACKAGE__->has_many("inscritos" => "R3S2::Schema::Result::Inscrito", "id") ;
__PACKAGE__->has_many("sede_distros" => "R3S2::Schema::Result::SedeDistro", "sede_id");
__PACKAGE__->many_to_many(distros => 'sede_distros', 'distro');
__PACKAGE__->has_many("usuarios" => "R3S2::Schema::Result::UsuarioSede",'sede_id');
__PACKAGE__->has_many("ponentes" => "R3S2::Schema::Result::Ponente", "id") ;


#Localizar las fechas
__PACKAGE__->add_columns(
        'fecha' => {
            data_type           => 'datetime',
            locale  => 'es_ES'
        },
    );


=head2 fecha_str
Formatea la fecha a formato legible
=cut

sub fecha_str {
    my ($self) = @_;
    my $day = $self->fecha->day;
    my $day_str = $self->fecha->day_name;
    my $month = $self->fecha->month_name;
    my $year = $self->fecha->year;
    return "$day_str $day de $month de $year";
}

1;
