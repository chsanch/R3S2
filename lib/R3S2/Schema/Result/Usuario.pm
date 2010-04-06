package R3S2::Schema::Result::Usuario;

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
__PACKAGE__->table("usuario");
__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    default_value => "nextval('usuario_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "username",
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
  "website",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("usuario_id", ["id"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-02-08 19:49:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:41CRrJgtZA56SKZYDh/gbA

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

#Relaciones
__PACKAGE__->has_many( "map_usuario_roles" => "R3S2::Schema::Result::UsuarioRol",'usuario_id');
#__PACKAGE__->has_many("sedes" => "R3S2::Schema::Result::UsuarioSede",'usuario_id');

__PACKAGE__->has_many("sede_usuarios" => "R3S2::Schema::Result::UsuarioSede", "usuario_id");
__PACKAGE__->many_to_many(sedes => 'sede_usuarios', 'sede');

__PACKAGE__->many_to_many(roles => 'map_usuario_roles', 'rol');

#Pesadilla con UTF-8 
__PACKAGE__->utf8_columns(qw/nombre apellido/);

1;
