use v6;
use strict;

use Test;
use Crypt::Argon2::DeriveKey;



my ($key, $meta) = argon2-derive-key("password");

my $test = argon2-derive-key("password", $meta);

my $same_key = True;
for ^$test.elems {
    if $test[$_] != $key[$_] {
        $same_key = False;
    }
}
ok $same_key, "Key can be successfully re-derived";
