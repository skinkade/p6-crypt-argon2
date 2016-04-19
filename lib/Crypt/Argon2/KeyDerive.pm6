use v6;
use strict;
use Crypt::Random;
use Crypt::Argon2::Base;


class Argon2-meta is export {
    has uint32 $.t_cost;
    has uint32 $.m_cost;
    has uint32 $.parallelism;
    has uint32 $.keylen;
    has Buf $.salt;
}

sub argon2-keygen(Str $pwd, :$t_cost = 3, :$m_cost = 65536,
                  :$parallelism = 2, :$keylen = 32) is export {

    my $key = Buf.new;
    $key[$keylen - 1] = 0;

    my $saltlen = 16;
    my $salt = crypt_random_buf($saltlen);

    argon2d_hash_raw($t_cost, $m_cost, $parallelism, $pwd, $pwd.encode.bytes,
                     $salt, $saltlen, $key, $keylen);

    my $meta = Argon2-meta.new(
        t_cost => $t_cost,
        m_cost => $m_cost,
        parallelism => $parallelism,
        hashlen => $keylen,
        salt => $salt);


    $key, $meta;
}
