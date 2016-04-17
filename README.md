# Crypt::Argon2
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
$ perl6 bin/argon2-benchmark.p6 
Running 100 iterations of argon2-verify() with the following settings:
    Time cost: 2
    Memory cost (kibibytes): 512
    Parallelism: 2
    Hash length: 16
Ms per verification: 2.63121664771647

$ perl6 bin/argon2-benchmark.p6 --t_cost=2 --m_cost=65536 --parallelism=6 --hashlen=32
Running 100 iterations of argon2-verify() with the following settings:
    Time cost: 2
    Memory cost (kibibytes): 65536
    Parallelism: 6
    Hash length: 32
Ms per verification: 102.423680430553
```
