use v6;
use strict;
use Crypt::Random;
use Crypt::Argon2::Base;

unit module Crypt::Argon2::KeyDerive;



class Argon2-meta is export {
    has uint32 $.t_cost is required;
    has uint32 $.m_cost is required;
    has uint32 $.parallelism is required;
    has uint32 $.keylen is required;
    has Buf $.salt is required;
}



sub argon2-keygen(Str $pwd, :$t_cost = 3, :$m_cost = 65536,
                  :$parallelism = 2, :$keylen = 32) is export {

    my $key = Buf.new;
    $key[$keylen - 1] = 0;

    my $saltlen = 16;
    my $salt = crypt_random_buf($saltlen);

    argon2d_hash_raw($t_cost, $m_cost, $parallelism, $pwd, $pwd.encode.bytes,
                     $salt, $saltlen, $key, $keylen);

    my $meta = Argon2-meta.new(:$t_cost, :$m_cost, :$parallelism, :$keylen, :$salt);

    $key, $meta;
}