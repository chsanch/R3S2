package R3S2::Schema::Result::Rol;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "EncodedColumn", "Core");
__PACKAGE__->table("rol");
__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    default_value => "nextval('role_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "nombre",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "descripcion",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("rol_id", ["id"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-02-03 21:52:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+PiLTfvbn++bpBXlBo2AJA

__PACKAGE__->has_many( "map_usuario_roles" => "R3S2::Schema::Result::UsuarioRol",'rol_id');

1;
