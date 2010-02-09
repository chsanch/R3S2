package R3S2::Schema::Result::Sede;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components(
  "InflateColumn::DateTime",
  "TimeStamp",
  "EncodedColumn",
  "UTF8Columns",
  "Core",
);
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


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-02-08 19:49:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:9bamXOkn4CbM2U1EVaiu+Q

#Relaciones 

__PACKAGE__->has_many("inscritos" => "R3S2::Schema::Result::Inscrito", "sede") ;
__PACKAGE__->has_many("sede_distros" => "R3S2::Schema::Result::SedeDistro", "sede_id");
__PACKAGE__->many_to_many(distros => 'sede_distros', 'distro');
__PACKAGE__->has_many("usuarios" => "R3S2::Schema::Result::UsuarioSede",'sede_id');
__PACKAGE__->has_many("ponentes" => "R3S2::Schema::Result::Ponente", "sede") ;
#UTF8
__PACKAGE__->utf8_columns(qw/ciudad lugar/);

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
