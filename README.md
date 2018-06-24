# bAESh
Hot, low speed AES encryption in Bash

### What's this?

This is an implementation of [**AES**](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard) encryption (128, 192 and 256 bits) in [**ecb, cbc, cfb(-128), ofb and ctr**](https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-38a.pdf) modes with PKCS#7 padding, using only pure [**bash**](https://tiswww.case.edu/php/chet/bash/bashtop.html) without any external programs. No dependencies, other than a recent version of bash.

**WARNING: THIS IS EXTREMELY SLOW AND INEFFICIENT. DO NOT USE IT FOR ANY SERIOUS PURPOSE, AND DO NOT USE IT ON LARGE AMOUNTS OF DATA (EVEN _A FEW TENS_ OF KB ARE ALREADY A LOT FOR THIS BEAST). YOU HAVE BEEN WARNED.**

### Why is it "hot"?

I'm glad you asked. Run it on a large file on your laptop and you'll see (and probably feel as well, if you're close enough). See the following graph, which represents the temperature of my laptop's CPU while encrypting a moderately large file (for bAESh's standards, anyway):

![bAESh CPU/Fan usage](https://github.com/waldner/bAESh/blob/master/baesh_cpu.png "CPU/Fan usage")

So it's not just hot, it's very hot. I'd go as far as saying that it's the hottest encryption program available.

### Why is it "low speed"?

See the following comparison with [openssl](https://www.openssl.org/) to encrypt a file:

<pre><code>
$ <b>ls -al /bin/rmdir</b>
-rwxr-xr-x 1 root root 42984 Dec 29 13:08 /bin/rmdir
$ <b>time openssl enc -aes-128-cbc -K '000102030405060708090a0b0c0d0e0f' -iv '11111111111111111111111111111111' < /bin/rmdir > /dev/null</b>

real	0m0.014s
user	0m0.009s
sys	0m0.003s
$ <b>time ./bAESh -b 128 -m cbc -K '000102030405060708090a0b0c0d0e0f' -I '11111111111111111111111111111111' < /bin/rmdir > /dev/null</b>

real	0m34.845s
user	0m33.064s
sys	0m1.552s
</code></pre>

Not bad eh?
So it's not just low speed, it's extremely low speed. I'd go as far as saying that it's the slowest encryption program available.

### How do I install it?

You really don't want to install it, but even if you wanted, no special installation would be necessary. Just run bAESh with the necessary arguments (see **`bAESh -h`** for help).

### How do I know that it produces correct results?

Just trust me!

No, seriously, bAESh comes with a test suite (big word) that runs a variety of tests with different key sizes, keys, IVs and inputs. There are essentially four kinds of tests:

- Key expansion tests
- Encryption/decryption tests against published NIST vectors for all modes (see [here](https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-38a.pdf), Appendix F)
- bAESh/[openssl](https://www.openssl.org/) crossed encryption/decryption (encrypt with bAESh, decrypt with openssl and viceversa) in all modes
- bAESh/[openssl](https://www.openssl.org/) output comparison (verify that the result of encryption/decryption is the same for both tools) in all modes

The tests use the [**assert.sh**](https://github.com/lehmannro/assert.sh) framework, which you should have installed somewhere. To run the tests, run the included **`baesh_tests.sh`** as follows (_WARNING: may take half an hour or more to runn the full thing_):

<pre><code>
$ <b>BAESH=/path/to/bAESh ASSERT_SH_PATH=/path/to/assert.sh ./baesh_tests.sh</b>
....
all 4 Key expansion, 128 bits tests passed in 0.063s.
...
all 3 Key expansion, 192 bits tests passed in 0.040s.
...
all 3 Key expansion, 256 bits tests passed in 0.044s.
..
all 2 ecb 128 bits, known text 0, key 0, raw output tests passed in 0.051s.
...snip...
</code></pre>

A third variable, **`BAESH_FULL_TEST`** can be set to 1 to run the fourth kind of tests above (the most resource-intensive).

### So, what's it good for?

Basically, nothing.

Well, unless you want to use your PC as a heater and do no real crypto work. In that case, throw some MBs at it to process and you should have a few hours of heating. Useful in winter. If it's especially cold, run many instances in parallel, so all CPUs can get a chance to overheat.

Otherwise, use real crypto tools.

