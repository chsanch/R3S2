package R3S2::Schema::Result::UsuarioRol;

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
__PACKAGE__->table("usuario_rol");
__PACKAGE__->add_columns(
  "usuario_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "rol_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("usuario_id", "rol_id");
__PACKAGE__->add_unique_constraint("usuario_rol_id", ["usuario_id", "rol_id"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-02-08 19:49:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:haDjp1nrWtie46ee59Bbyw

__PACKAGE__->belongs_to(usuario => 'R3S2::Schema::Result::Usuario', 'usuario_id');
__PACKAGE__->belongs_to(rol => 'R3S2::Schema::Result::Rol', 'rol_id');
 
 
1;
