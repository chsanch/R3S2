package R3S2::View::Email;

use strict;
use base 'Catalyst::View::Email';

__PACKAGE__->config(
    stash_key => 'email'
);

=head1 NAME

R3S2::View::Email - Email View for R3S2

=head1 DESCRIPTION

View for sending email from R3S2. 

=head1 AUTHOR

Christian Sánchez

=head1 SEE ALSO

L<R3S2>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;