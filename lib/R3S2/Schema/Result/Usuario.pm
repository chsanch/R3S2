package R3S2::Schema::Result::Usuario;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "EncodedColumn", "Core");
__PACKAGE__->table("usuario");
__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    default_value => "nextval('usuario_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "login",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "password",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "nombre",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "apellido",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "activo",
  { data_type => "integer", default_value => 1, is_nullable => 1, size => 4 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("usuario_id", ["id"]);
__PACKAGE__->has_many(
  "usuario_rols",
  "R3S2::Schema::Result::UsuarioRol",
  { "foreign.usuario_id" => "self.id" },
);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-12-20 17:28:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Bjut92dIQ6KLQNhSAK7Awg

#Para cifrar la clave
__PACKAGE__->add_columns(
        'password' => {
            data_type           => "TEXT",
            size                => undef,
            encode_column       => 1,
            encode_class        => 'Digest',
            encode_args         => {algorithm => 'SHA-1', format => 'hex', salt_length => 10},
            encode_check_method => 'check_password',
        },
    );

# You can replace this text with custom content, and it will be preserved on regeneration
1;
