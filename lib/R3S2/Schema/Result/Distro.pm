package R3S2::Schema::Result::Distro;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "EncodedColumn", "Core");
__PACKAGE__->table("distro");
__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    default_value => "nextval('distro_id_seq'::regclass)",
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
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("distro_id", ["id"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-02-04 16:13:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:vmgoxTdG0J8PYvAz16kOfw

__PACKAGE__->has_many("sede_distros" => "R3S2::Schema::Result::SedeDistro", "distro_id");
__PACKAGE__->many_to_many(sedes => 'sede_distros', 'sede');


1;
