package App::OpenStreetMapIs::Web::Model::Status::Highways;
use Moose;
use namespace::autoclean;
use DBI;
use Encode qw(decode encode);

extends 'Catalyst::Model';

=head1 NAME

App::OpenStreetMapIs::Web::Model::Status::Highway - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

sub get_highway_relations
{
    my ($self) = @_;

    my $relations = relations();
    my $highway_relations = highway_relations($relations);
}

sub highway_relations
{
    my $relations = shift;

    my %highway_relations = map { $_ => $relations->{$_} } grep {
        my $tags = $relations->{ $_ }->{tags};

        $tags->{ type } eq "route" and
        $tags->{ route } eq "road" and
        exists $tags->{ ref } and
        $tags->{ network } =~ /^[STLH;]+$/
    } keys %$relations;

    \%highway_relations;
}

sub relations
{
    my $self = shift;
    my $dbh = DBI->connect("dbi:Pg:dbname=osmis;host=localhost", qw(osmis osmis));

    my @relations = @{$dbh->selectall_arrayref("SELECT id,k,v FROM current_relation_tags")};

    my %relations;

    for my $relation (@relations) {
        my $id = $relation->[0];
        my @tags = @{ $dbh->selectall_arrayref("SELECT k,v FROM current_relation_tags WHERE id=$id") };

        for my $tag (@tags) {
            $relations{$id}->{tags}{ $tag->[0] } = decode("utf-8", $tag->[1]);
        }

        # # Get the members
        # my @members = @{ $dbh->selectall_arrayref("select * from current_relation_members where id = $id order by sequence_id") };

        # for my $member (@members) {
        #     my (undef, $type, $member_id) = @$member;
        #     $type = lc $type;

        #     my @member_tags = @{ $dbh->selectall_arrayref("SELECT k,v FROM current_${type}_tags WHERE id=$member_id") };
        #     my %tags;
        #     for my $tag (@member_tags) {
        #         $tags{ $tag->[0] } = encode("utf-8", decode("utf-8", $tag->[1]));;
        #     }

        #     push @{ $relations{$id}->{members}->{$type} } => [ $member_id, \%tags ];
        # }
    }

    \%relations;
}

__PACKAGE__->meta->make_immutable;

