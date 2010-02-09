package R3S2::Schema::Result::Ponente;

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
__PACKAGE__->table("ponente");
__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    default_value => "nextval('ponente_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "nombres",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "apellidos",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "email",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "twitter",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "url",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "fecha_ins",
  { data_type => "date", default_value => undef, is_nullable => 1, size => 4 },
  "sede",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "titulo_ponencia",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "descripcion_ponencia",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "aceptada",
  { data_type => "character", default_value => 0, is_nullable => 1, size => 1 },
  "ciudad",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "fecha_nac",
  { data_type => "date", default_value => undef, is_nullable => 1, size => 4 },
  "organizacion",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("ponente_id", ["id"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-02-08 19:49:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2mGSxKUHZloQZ5VhURk4NQ

 __PACKAGE__->resultset_class('R3S2::Schema::ResultSet::Ponente');
 
 __PACKAGE__->belongs_to(sede => 'R3S2::Schema::Result::Sede', 'sede');

__PACKAGE__->add_columns(
    "fecha_ins",
    { data_type => 'datetime', set_on_create => 1 },
);

#UTF-8
__PACKAGE__->utf8_columns(qw/ciudad nombres apellidos titulo_ponencia descripcion_ponencia/);

1;
