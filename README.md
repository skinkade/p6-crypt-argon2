# Crypt::Argon2
Easy Argon2i password hashing in Perl6.

## Synopsis
```
> use Crypt::Argon2;

> my $hash = argon2-hash("password")
$argon2i$v=19$m=512,t=2,p=1$PkdJHV8sTSAp9ke+beW0yw$pckYx7BBHYz4Iq/FX+nQCA

> argon2-verify($hash, "password")
True

> argon2-verify($hash, "password1")
False

> my $hard-hash = argon2-hash("password", :t_cost(4), :m_cost(2**16), :parallelism(2), :hashlen(32))
$argon2i$v=19$m=65536,t=4,p=2$QXtq7Djxz/q2h2uAFTy46g$D14zBbQDvfxjIOjCNCM0CsymTb5lns04CoOIMQUJYcs
```
