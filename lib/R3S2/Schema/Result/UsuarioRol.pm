package R3S2::Schema::Result::UsuarioRol;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "EncodedColumn", "Core");
__PACKAGE__->table("usuario_rol");
__PACKAGE__->add_columns(
  "usuario_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "rol_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("usuario_id", "rol_id");
__PACKAGE__->add_unique_constraint("usuario_rol_id", ["usuario_id", "rol_id"]);
__PACKAGE__->belongs_to(
  "usuario_id",
  "R3S2::Schema::Result::Usuario",
  { id => "usuario_id" },
);
__PACKAGE__->belongs_to("rol_id", "R3S2::Schema::Result::Rol", { id => "rol_id" });


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-12-20 17:28:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:NnoUrQHqdmEk4+WnrJ7Vug


# You can replace this text with custom content, and it will be preserved on regeneration
1;
