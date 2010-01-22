package App::OpenStreetMapIs::Web::Controller::Status::Highways;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

App::OpenStreetMapIs::Web::Controller::Status::Highways - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    my $hw = $c->model("Status::Highways");

    my $hwr = highway_html($hw->get_highway_relations);

    $c->stash->{highway_html} = $hwr;
    $c->stash->{template} = 'status/highways.tt';
}

sub highway_html
{
    my $highways = shift;

    my $out;

    while (my ($k, $v) = each %$highways) {
        $out .= "<tr>\n";
        $out .= "  <td>$v->{tags}->{ref}</td>\n";
        $out .= "  <td>$v->{tags}->{name}</td>\n";
        $out .= "  <td>$v->{tags}->{network}</td>\n";
        $out .= "  <td><a href='http://osm.org/browse/relation/$k'>$k</a></td>\n";
        $out .= "</tr>\n";
    }

    return $out;
}


=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

