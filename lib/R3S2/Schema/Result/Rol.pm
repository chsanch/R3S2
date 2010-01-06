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
__PACKAGE__->has_many(
  "usuario_rols",
  "R3S2::Schema::Result::UsuarioRol",
  { "foreign.rol_id" => "self.id" },
);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-12-20 17:28:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:KRW6P+zBvsnW/0ZuQ5Hdpw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
