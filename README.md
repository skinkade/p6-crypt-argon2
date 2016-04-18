# Crypt::Argon2 [![Build Status](https://travis-ci.org/skinkade/p6-crypt-argon2.svg?branch=master)](https://travis-ci.org/skinkade/p6-crypt-argon2)
Easy Argon2i password hashing in Perl6.

## Synopsis
```
> use Crypt::Argon2;

> my $hash = argon2-hash("password")
$argon2i$v=19$m=512,t=2,p=2$v+loufJytQuBw5KdkKxaWA$5TWMJQg8B0KdQ6lU/ZfQWg

> argon2-verify($hash, "password")
True

> argon2-verify($hash, "wrong")
False

> my $hard-hash = argon2-hash("password", :t_cost(4), :m_cost(2**16), :parallelism(2), :hashlen(32))
$argon2i$v=19$m=65536,t=4,p=2$QXtq7Djxz/q2h2uAFTy46g$D14zBbQDvfxjIOjCNCM0CsymTb5lns04CoOIMQUJYcs
```

## Cost Parameters
The default parameters are those of Python's [argon2_cffi](https://github.com/hynek/argon2_cffi),
intended for use with numerous concurrent user logins.

To help determine values appropriate for your use, `bin/argon2-benchmark.p6` is included.
```
$ perl6 argon2-benchmark.p6
Running 100 iterations of argon2-verify() with the following settings:
    Time cost: 2
    Memory: 512 KiB
    Parallelism: 2 threads
    Hash length: 16 bytes
Time per verification: 2.48 ms

$ perl6 argon2-benchmark.p6 --t_cost=2 --m_cost=65536 --parallelism=6 --hashlen=32
Running 100 iterations of argon2-verify() with the following settings:
    Time cost: 2
    Memory: 65536 KiB
    Parallelism: 6 threads
    Hash length: 32 bytes
Time per verification: 102.52 ms
```

## Argon2d Key Generation
Argon2**i** is recommended for password hashing, and Argon2**d** for generating
keys. If there is interest, I will extend the library binding and create a
sub-module intended for this latter purpose.
