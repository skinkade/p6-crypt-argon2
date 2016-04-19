# Crypt::Argon2 [![Build Status](https://travis-ci.org/skinkade/p6-crypt-argon2.svg?branch=master)](https://travis-ci.org/skinkade/p6-crypt-argon2)
Easy Argon2 password hashing and key derivation in Perl6.

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
keys. The former is resistant to side-channel attacks, while the latter is
better against GPU-based attacks. Only use Argon2**d** if you know your
environment is side-channel-free.

In lieu of the `crypt()`-style encoded string provided by the main library,
the key derivation module returns `(Buf $key, Argon2-meta $meta)`, where `$meta`
contains the necessary metadata for recreating `$key`.

Optional parameters for `argon2-derive-key()` are the same as `argon2-hash()`,
except for `$hashlen` being renamed to `$keylen` for clarity.

```
> use Crypt::Argon2::DeriveKey;

> my ($key, $meta) = argon2-derive-key("password");
...
> $key;
Buf:0x<d5 f6 8d 4b ca c7 73 2d ce 0a 6d e1 8f c2 6d 56 4d 6f ee 10 c3 5d 16 6b 5b 7d 92 28 41 96 92 f5>

> argon2-derive-key("password", $meta);
Buf:0x<d5 f6 8d 4b ca c7 73 2d ce 0a 6d e1 8f c2 6d 56 4d 6f ee 10 c3 5d 16 6b 5b 7d 92 28 41 96 92 f5>
```
