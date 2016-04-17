use v6;
use strict;

use Crypt::Argon2;



sub MAIN (int :$t_cost = 2, int :$m_cost = 512, int :$parallelism = 2, int :$hashlen = 16) {
    say "Running 100 iterations of argon2-verify() with the following settings:";
    say "\tTime cost: "~$t_cost;
    say "\tMemory cost (kibibytes): "~$m_cost;
    say "\tParallelism: "~$parallelism;
    say "\tHash length: "~$hashlen;

    my $hash = argon2-hash("", :t_cost($t_cost), :m_cost($m_cost),
                           :parallelism($parallelism), :hashlen($hashlen));

    my $start = now;
    for 1..100 {
        argon2-verify($hash, "");
    }
    my $stop = now;

    say "Ms per verification: "~(($stop - $start) * 10);
}
