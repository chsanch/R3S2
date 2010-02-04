package R3S2::Schema::Result::SedeDistro;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "EncodedColumn", "Core");
__PACKAGE__->table("sede_distro");
__PACKAGE__->add_columns(
  "sede_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "distro_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("sede_id", "distro_id");
__PACKAGE__->add_unique_constraint("sede_distro_id", ["sede_id", "distro_id"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-02-03 21:52:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:gcWsGINIKcb69Xd54PQUOw

 __PACKAGE__->belongs_to(sede => 'R3S2::Schema::Result::Sede', 'sede_id');
 __PACKAGE__->belongs_to(distro => 'R3S2::Schema::Result::Distro', 'distro_id');
 
1;
