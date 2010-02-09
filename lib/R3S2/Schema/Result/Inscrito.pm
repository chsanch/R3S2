package R3S2::Schema::Result::Inscrito;

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
__PACKAGE__->table("inscrito");
__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    default_value => "nextval('inscrito_id_seq'::regclass)",
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
  "tipo_comp",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "tipo_proc",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "cant_ram",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "esp_dd",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "distro",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "comentarios",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "sede",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "uso_linux_antes",
  { data_type => "character", default_value => 0, is_nullable => 1, size => 1 },
  "ccsef",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "fecha_ins",
  { data_type => "date", default_value => undef, is_nullable => 1, size => 4 },
  "url",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "fecha_nac",
  { data_type => "date", default_value => undef, is_nullable => 1, size => 4 },
  "ciudad",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("inscrito_id", ["id"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-02-08 19:49:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:cRQ3nClMikt8jOZF3EQqfQ

 __PACKAGE__->belongs_to(sede => 'R3S2::Schema::Result::Sede', 'sede');

__PACKAGE__->add_columns(
    "fecha_ins",
    { data_type => 'datetime', set_on_create => 1 },
);

#UTF-8
__PACKAGE__->utf8_columns(qw/ciudad nombres apellidos comentarios/);

1;
