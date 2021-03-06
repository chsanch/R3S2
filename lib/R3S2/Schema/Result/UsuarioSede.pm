package R3S2::Schema::Result::UsuarioSede;

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
__PACKAGE__->table("usuario_sede");
__PACKAGE__->add_columns(
  "usuario_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "sede_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("usuario_id", "sede_id");
__PACKAGE__->add_unique_constraint("usuario_sede_id", ["usuario_id", "sede_id"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-02-08 19:49:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:SLCh7B9Pixr65eKlWvCPXw

 __PACKAGE__->belongs_to(usuario => 'R3S2::Schema::Result::Usuario', 'usuario_id');
 __PACKAGE__->belongs_to(sede => 'R3S2::Schema::Result::Sede', 'sede_id');

1;
