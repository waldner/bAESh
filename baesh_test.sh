#!/bin/bash

declare -A AES_128bit_expansions=( 
['00000000000000000000000000000000']='00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
62 63 63 63 62 63 63 63 62 63 63 63 62 63 63 63
9b 98 98 c9 f9 fb fb aa 9b 98 98 c9 f9 fb fb aa
90 97 34 50 69 6c cf fa f2 f4 57 33 0b 0f ac 99
ee 06 da 7b 87 6a 15 81 75 9e 42 b2 7e 91 ee 2b
7f 2e 2b 88 f8 44 3e 09 8d da 7c bb f3 4b 92 90
ec 61 4b 85 14 25 75 8c 99 ff 09 37 6a b4 9b a7
21 75 17 87 35 50 62 0b ac af 6b 3c c6 1b f0 9b
0e f9 03 33 3b a9 61 38 97 06 0a 04 51 1d fa 9f
b1 d4 d8 e2 8a 7d b9 da 1d 7b b3 de 4c 66 49 41
b4 ef 5b cb 3e 92 e2 11 23 e9 51 cf 6f 8f 18 8e'

['ffffffffffffffffffffffffffffffff']='ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e8 e9 e9 e9 17 16 16 16 e8 e9 e9 e9 17 16 16 16
ad ae ae 19 ba b8 b8 0f 52 51 51 e6 45 47 47 f0
09 0e 22 77 b3 b6 9a 78 e1 e7 cb 9e a4 a0 8c 6e
e1 6a bd 3e 52 dc 27 46 b3 3b ec d8 17 9b 60 b6
e5 ba f3 ce b7 66 d4 88 04 5d 38 50 13 c6 58 e6
71 d0 7d b3 c6 b6 a9 3b c2 eb 91 6b d1 2d c9 8d
e9 0d 20 8d 2f bb 89 b6 ed 50 18 dd 3c 7d d1 50
96 33 73 66 b9 88 fa d0 54 d8 e2 0d 68 a5 33 5d
8b f0 3f 23 32 78 c5 f3 66 a0 27 fe 0e 05 14 a3
d6 0a 35 88 e4 72 f0 7b 82 d2 d7 85 8c d7 c3 26'

['000102030405060708090a0b0c0d0e0f']='00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
d6 aa 74 fd d2 af 72 fa da a6 78 f1 d6 ab 76 fe
b6 92 cf 0b 64 3d bd f1 be 9b c5 00 68 30 b3 fe
b6 ff 74 4e d2 c2 c9 bf 6c 59 0c bf 04 69 bf 41
47 f7 f7 bc 95 35 3e 03 f9 6c 32 bc fd 05 8d fd
3c aa a3 e8 a9 9f 9d eb 50 f3 af 57 ad f6 22 aa
5e 39 0f 7d f7 a6 92 96 a7 55 3d c1 0a a3 1f 6b
14 f9 70 1a e3 5f e2 8c 44 0a df 4d 4e a9 c0 26
47 43 87 35 a4 1c 65 b9 e0 16 ba f4 ae bf 7a d2
54 99 32 d1 f0 85 57 68 10 93 ed 9c be 2c 97 4e
13 11 1d 7f e3 94 4a 17 f3 07 a7 8b 4d 2b 30 c5'

['6920e299a5202a6d656e636869746f2a']='69 20 e2 99 a5 20 2a 6d 65 6e 63 68 69 74 6f 2a
fa 88 07 60 5f a8 2d 0d 3a c6 4e 65 53 b2 21 4f
cf 75 83 8d 90 dd ae 80 aa 1b e0 e5 f9 a9 c1 aa
18 0d 2f 14 88 d0 81 94 22 cb 61 71 db 62 a0 db
ba ed 96 ad 32 3d 17 39 10 f6 76 48 cb 94 d6 93
88 1b 4a b2 ba 26 5d 8b aa d0 2b c3 61 44 fd 50
b3 4f 19 5d 09 69 44 d6 a3 b9 6f 15 c2 fd 92 45
a7 00 77 78 ae 69 33 ae 0d d0 5c bb cf 2d ce fe
ff 8b cc f2 51 e2 ff 5c 5c 32 a3 e7 93 1f 6d 19
24 b7 18 2e 75 55 e7 72 29 67 44 95 ba 78 29 8c
ae 12 7c da db 47 9b a8 f2 20 df 3d 48 58 f6 b1'
)

declare -A AES_192bit_expansions=( 
['000000000000000000000000000000000000000000000000']='00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 62 63 63 63 62 63 63 63
62 63 63 63 62 63 63 63 62 63 63 63 62 63 63 63
9b 98 98 c9 f9 fb fb aa 9b 98 98 c9 f9 fb fb aa
9b 98 98 c9 f9 fb fb aa 90 97 34 50 69 6c cf fa
f2 f4 57 33 0b 0f ac 99 90 97 34 50 69 6c cf fa
c8 1d 19 a9 a1 71 d6 53 53 85 81 60 58 8a 2d f9
c8 1d 19 a9 a1 71 d6 53 7b eb f4 9b da 9a 22 c8
89 1f a3 a8 d1 95 8e 51 19 88 97 f8 b8 f9 41 ab
c2 68 96 f7 18 f2 b4 3f 91 ed 17 97 40 78 99 c6
59 f0 0e 3e e1 09 4f 95 83 ec bc 0f 9b 1e 08 30
0a f3 1f a7 4a 8b 86 61 13 7b 88 5f f2 72 c7 ca
43 2a c8 86 d8 34 c0 b6 d2 c7 df 11 98 4c 59 70'

['ffffffffffffffffffffffffffffffffffffffffffffffff']='ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff ff e8 e9 e9 e9 17 16 16 16
e8 e9 e9 e9 17 16 16 16 e8 e9 e9 e9 17 16 16 16
ad ae ae 19 ba b8 b8 0f 52 51 51 e6 45 47 47 f0
ad ae ae 19 ba b8 b8 0f c5 c2 d8 ed 7f 7a 60 e2
2d 2b 31 04 68 6c 76 f4 c5 c2 d8 ed 7f 7a 60 e2
17 12 40 3f 68 68 20 dd 45 43 11 d9 2d 2f 67 2d
e8 ed bf c0 97 97 df 22 8f 8c d3 b7 e7 e4 f3 6a
a2 a7 e2 b3 8f 88 85 9e 67 65 3a 5e f0 f2 e5 7c
26 55 c3 3b c1 b1 30 51 63 16 d2 e2 ec 9e 57 7c
8b fb 6d 22 7b 09 88 5e 67 91 9b 1a a6 20 ab 4b
c5 36 79 a9 29 a8 2e d5 a2 53 43 f7 d9 5a cb a9
59 8e 48 2f ff ae e3 64 3a 98 9a cd 13 30 b4 18'


['000102030405060708090a0b0c0d0e0f1011121314151617']='00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
10 11 12 13 14 15 16 17 58 46 f2 f9 5c 43 f4 fe
54 4a fe f5 58 47 f0 fa 48 56 e2 e9 5c 43 f4 fe
40 f9 49 b3 1c ba bd 4d 48 f0 43 b8 10 b7 b3 42
58 e1 51 ab 04 a2 a5 55 7e ff b5 41 62 45 08 0c
2a b5 4b b4 3a 02 f8 f6 62 e3 a9 5d 66 41 0c 08
f5 01 85 72 97 44 8d 7e bd f1 c6 ca 87 f3 3e 3c
e5 10 97 61 83 51 9b 69 34 15 7c 9e a3 51 f1 e0
1e a0 37 2a 99 53 09 16 7c 43 9e 77 ff 12 05 1e
dd 7e 0e 88 7e 2f ff 68 60 8f c8 42 f9 dc c1 54
85 9f 5f 23 7a 8d 5a 3d c0 c0 29 52 be ef d6 3a
de 60 1e 78 27 bc df 2c a2 23 80 0f d8 ae da 32
a4 97 0a 33 1a 78 dc 09 c4 18 c2 71 e3 a4 1d 5d'
)

declare -A AES_256bit_expansions=( 
['0000000000000000000000000000000000000000000000000000000000000000']='00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
62 63 63 63 62 63 63 63 62 63 63 63 62 63 63 63
aa fb fb fb aa fb fb fb aa fb fb fb aa fb fb fb
6f 6c 6c cf 0d 0f 0f ac 6f 6c 6c cf 0d 0f 0f ac
7d 8d 8d 6a d7 76 76 91 7d 8d 8d 6a d7 76 76 91
53 54 ed c1 5e 5b e2 6d 31 37 8e a2 3c 38 81 0e
96 8a 81 c1 41 fc f7 50 3c 71 7a 3a eb 07 0c ab
9e aa 8f 28 c0 f1 6d 45 f1 c6 e3 e7 cd fe 62 e9
2b 31 2b df 6a cd dc 8f 56 bc a6 b5 bd bb aa 1e
64 06 fd 52 a4 f7 90 17 55 31 73 f0 98 cf 11 19
6d bb a9 0b 07 76 75 84 51 ca d3 31 ec 71 79 2f
e7 b0 e8 9c 43 47 78 8b 16 76 0b 7b 8e b9 1a 62
74 ed 0b a1 73 9b 7e 25 22 51 ad 14 ce 20 d4 3b
10 f8 0a 17 53 bf 72 9c 45 c9 79 e7 cb 70 63 85'

['ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff']='ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e8 e9 e9 e9 17 16 16 16 e8 e9 e9 e9 17 16 16 16
0f b8 b8 b8 f0 47 47 47 0f b8 b8 b8 f0 47 47 47
4a 49 49 65 5d 5f 5f 73 b5 b6 b6 9a a2 a0 a0 8c
35 58 58 dc c5 1f 1f 9b ca a7 a7 23 3a e0 e0 64
af a8 0a e5 f2 f7 55 96 47 41 e3 0c e5 e1 43 80
ec a0 42 11 29 bf 5d 8a e3 18 fa a9 d9 f8 1a cd
e6 0a b7 d0 14 fd e2 46 53 bc 01 4a b6 5d 42 ca
a2 ec 6e 65 8b 53 33 ef 68 4b c9 46 b1 b3 d3 8b
9b 6c 8a 18 8f 91 68 5e dc 2d 69 14 6a 70 2b de
a0 bd 9f 78 2b ee ac 97 43 a5 65 d1 f2 16 b6 5a
fc 22 34 91 73 b3 5c cf af 9e 35 db c5 ee 1e 05
06 95 ed 13 2d 7b 41 84 6e de 24 55 9c c8 92 0f
54 6d 42 4f 27 de 1e 80 88 40 2b 5b 4d ae 35 5e'

['000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f']='00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f
a5 73 c2 9f a1 76 c4 98 a9 7f ce 93 a5 72 c0 9c
16 51 a8 cd 02 44 be da 1a 5d a4 c1 06 40 ba de
ae 87 df f0 0f f1 1b 68 a6 8e d5 fb 03 fc 15 67
6d e1 f1 48 6f a5 4f 92 75 f8 eb 53 73 b8 51 8d
c6 56 82 7f c9 a7 99 17 6f 29 4c ec 6c d5 59 8b
3d e2 3a 75 52 47 75 e7 27 bf 9e b4 54 07 cf 39
0b dc 90 5f c2 7b 09 48 ad 52 45 a4 c1 87 1c 2f
45 f5 a6 60 17 b2 d3 87 30 0d 4d 33 64 0a 82 0a
7c cf f7 1c be b4 fe 54 13 e6 bb f0 d2 61 a7 df
f0 1a fa fe e7 a8 29 79 d7 a5 64 4a b3 af e6 40
25 41 fe 71 9b f5 00 25 88 13 bb d5 5a 72 1c 0a
4e 5a 66 99 a9 f2 4f e0 7e 57 2b aa cd f8 cd ea
24 fc 79 cc bf 09 79 e9 37 1a c2 3c 6d 68 de 36'
)

declare -A nist_keys=(
  [128]='2b7e151628aed2a6abf7158809cf4f3c'
  [192]='8e73b0f7da0e6452c810f32b809079e562f8ead2522c6b7b'
  [256]='603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4'
)

nist_iv='000102030405060708090a0b0c0d0e0f'
nist_counter='f0f1f2f3f4f5f6f7f8f9fafbfcfdfeff'

nist_plaintext='6bc1bee22e409f96e93d7e117393172a
ae2d8a571e03ac9c9eb76fac45af8e51
30c81c46a35ce411e5fbc1191a0a52ef
f69f2445df4f9b17ad2b417be66c3710'

# ecb and cbc slightly modified to account for padding
declare -A nist_ciphertexts=(
  [aes_128_ecb]='3ad77bb40d7a3660a89ecaf32466ef97
f5d3d58503b9699de785895a96fdbaaf
43b1cd7f598ece23881b00e3ed030688
7b0c785e27e8ad3f8223207104725dd4
a254be88e037ddd9d79fb6411c3f9df8'
  [aes_192_ecb]='bd334f1d6e45f25ff712a214571fa5cc
974104846d0ad3ad7734ecb3ecee4eef
ef7afd2270e2e60adce0ba2face6444e
9a4b41ba738d6c72fb16691603c18e0e
daa0af074bd8083c8a32d4fc563c55cc'
  [aes_256_ecb]='f3eed1bdb5d2a03c064b5a7e3db181f8
591ccb10d410ed26dc5ba74a31362870
b6ed21b99ca6f4f9f153e7b1beafed1d
23304b7a39f9f3ff067d8d8f9e24ecc7
4c45dfb3b3b484ec35b0512dc8c1c4d6'
  [aes_128_cbc]='7649abac8119b246cee98e9b12e9197d
5086cb9b507219ee95db113a917678b2
73bed6b8e3c1743b7116e69e22229516
3ff1caa1681fac09120eca307586e1a7
8cb82807230e1321d3fae00d18cc2012'
  [aes_192_cbc]='4f021db243bc633d7178183a9fa071e8
b4d9ada9ad7dedf4e5e738763f69145a
571b242012fb7ae07fa9baac3df102e0
08b0e27988598881d920a9e64f5615cd
612ccd79224b350935d45dd6a98f8176'
  [aes_256_cbc]='f58c4c04d6e5f1ba779eabfb5f7bfbd6
9cfc4e967edb808d679f777bc6702c7d
39f23369a9d9bacfa530e26304231461
b2eb05e2c39be9fcda6c19078c6a9d1b
3f461796d6b0d6b2e0c2a72b4d80e644'
  [aes_128_cfb]='3b3fd92eb72dad20333449f8e83cfb4a
c8a64537a0b3a93fcde3cdad9f1ce58b
26751f67a3cbb140b1808cf187a4f4df
c04b05357c5d1c0eeac4c66f9ff7f2e6'
  [aes_192_cfb]='cdc80d6fddf18cab34c25909c99a4174
67ce7f7f81173621961a2b70171d3d7a
2e1e8a1dd59b88b1c8e60fed1efac4c9
c05f9f9ca9834fa042ae8fba584b09ff'
  [aes_256_cfb]='dc7e84bfda79164b7ecd8486985d3860
39ffed143b28b1c832113c6331e5407b
df10132415e54b92a13ed0a8267ae2f9
75a385741ab9cef82031623d55b1e471'
  [aes_128_ofb]='3b3fd92eb72dad20333449f8e83cfb4a
7789508d16918f03f53c52dac54ed825
9740051e9c5fecf64344f7a82260edcc
304c6528f659c77866a510d9c1d6ae5e'
  [aes_192_ofb]='cdc80d6fddf18cab34c25909c99a4174
fcc28b8d4c63837c09e81700c1100401
8d9a9aeac0f6596f559c6d4daf59a5f2
6d9f200857ca6c3e9cac524bd9acc92a'
  [aes_256_ofb]='dc7e84bfda79164b7ecd8486985d3860
4febdc6740d20b3ac88f6ad82a4fb08d
71ab47a086e86eedf39d1c5bba97c408
0126141d67f37be8538f5a8be740e484'
  [aes_128_ctr]='874d6191b620e3261bef6864990db6ce
9806f66b7970fdff8617187bb9fffdff
5ae4df3edbd5d35e5b4f09020db03eab
1e031dda2fbe03d1792170a0f3009cee'
  [aes_192_ctr]='1abc932417521ca24f2b0459fe7e6e0b
090339ec0aa6faefd5ccc2c6f4ce8e94
1e36b26bd1ebc670d1bd1d665620abf7
4f78a7f6d29809585a97daec58c6b050'
  [aes_256_ctr]='601ec313775789a5b7a7f504bbf3d228
f443e3ca4d62b59aca84e990cacaf5c5
2b0930daa23de94ce87017ba2d84988d
dfc9c58db67aada613c2dd08457941a6'
)

declare -A plaintexts=(
  [0]=''
  [1]='abcdefghijklmno'
  [2]='azzzzzxhijklm&&&'
  [3]='a*cd[fgh!jk[mno]#'
  [4]='1234567890123456123456789012345'
  [5]='_-+^+-_-_-_-_-_+_/_"_x_(_)_=_?_a'
  [6]='123456789012345612345678901234561'
  [7]='Jun 20 18:01:49 scooter dovecot: imap-login: Login: user=<xxxx@xxxxxxxxx.xx>, method=PLAIN, rip=xx.yy.zz.ww, lip=aa.bb.cc.dd, mpid=18174, TLS, session=<uD2Y6hRvO8W8CTgJ>'
)

declare -A IVs=(
  [0]='000000000000000000000000000000ff'
  [1]='12345678909876543212345678909876'
  [2]='625188a5ac8ede44f84cdf07d9ae1163'
  [3]='abcdefabcdefabcdefabcdefabcdefab'
)

declare -A keys128=(
  [0]='0f101112131415161718191a1b1c1d1f'
  [1]='aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab'
  [2]='00000000000100000000000000000000'
  [3]='38742984797292987837878abf736aff'
)

declare -A keys192=(
  [0]='01030507090b0d0f101112131415161718191a1b1c1d1e1f'
  [1]='29379897977897128788788783485457592837438329834a'
  [2]='f0000000000000000000000000000000000000000000000f'
  [3]='02132435465768798a9bacbdcedfe0f10213243546576879'
)

declare -A keys256=(
  [0]='000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f'
  [1]='a3aea0458018b593464a08a2b717d04d2bf1136374237a65c641994ff55cfc15'
  [2]='5e00eb116ab33f8d22822477c344d6bf9102cb9cbdc4a8c00f5776e55c827392'
  [3]='5b7ed76a89206ec6b4e7a8ae5f2408bd3667ddccb00a9eede8a8ad7528d322ac'
)

print_nist_to_raw(){

  local hex=$1

  local join i
  local -a array

  join=$(tr -d '\n' <<< "$hex")

  array=()
  for ((i = 0; i < ${#join} / 2; i++)); do
    array[i]=$(( 16#${join:i*2:2} ))
  done

  printf "$(printf '\\x%x' "${array[@]}")"

}


baesh_file=/tmp/baesh_result
other_file=/tmp/other_result
openssl_file=/tmp/openssl

#random_bytes=3091
random_bytes=999

: "${BAESH_FULL_TEST:=0}"
: "${ASSERT_SH_PATH:=$HOME/bin/assert.sh}"    # this is a DIRECTORY name

: "${BAESH:=./bAESh}"

baesh=$BAESH

if [ ! -x "${baesh}" ]; then
  echo "Cannot find bAESh script at $baesh" >&2
  exit 1
fi

if [ ! -r "${ASSERT_SH_PATH}/assert.sh" ]; then
  echo "Cannot find assert.sh at ${ASSERT_SH_PATH}/assert.sh" >&2
  exit 1
fi

. "${ASSERT_SH_PATH}"/assert.sh -v -x


###### key expansion tests ###################
for key in "${!AES_128bit_expansions[@]}"; do
  ${baesh} -K "$key" -b 128 -x > $baesh_file
  echo "${AES_128bit_expansions[$key]}" > $other_file
  assert_raises "diff $baesh_file $other_file" 0
done

assert_end "Key expansion, 128 bits"

for key in "${!AES_192bit_expansions[@]}"; do
  ${baesh} -K "$key" -b 192 -x > $baesh_file
  echo "${AES_192bit_expansions[$key]}" > $other_file
  assert_raises "diff $baesh_file $other_file" 0
done

assert_end "Key expansion, 192 bits"

for key in "${!AES_256bit_expansions[@]}"; do
  ${baesh} -K "$key" -b 256 -x > $baesh_file
  echo "${AES_256bit_expansions[$key]}" > $other_file
  assert_raises "diff $baesh_file $other_file" 0
done

assert_end "Key expansion, 256 bits"

###### NIST tests #################

for mode in ecb cbc cfb ofb ctr; do
  for bits in 128 192 256; do

    declare -a iv_arg

    if [ $mode = "ctr" ]; then
      iv_arg=( -I "$nist_counter" )
    elif [ "$mode" != "ecb" ]; then
      iv_arg=( -I "$nist_iv" )
    else
      iv_arg=()
    fi

    # encryption test

    assert 'print_nist_to_raw "$nist_plaintext" | ${baesh} "${iv_arg[@]}" -K "${nist_keys[$bits]}" -b $bits -m ${mode} -o hex' "${nist_ciphertexts[aes_${bits}_${mode}]}"
    assert_end "${mode} ${bits} bits, NIST encryption"

    # decryption_test
    assert 'print_nist_to_raw "${nist_ciphertexts[aes_${bits}_${mode}]}" | ${baesh} -d "${iv_arg[@]}" -K "${nist_keys[$bits]}" -b $bits -m ${mode} -o hex' "${nist_plaintext}"
    assert_end "${mode} ${bits} bits, NIST decryption"
  done
done

##### other tests #################

for bits in 128 192 256; do

  if [ $bits -eq 128 ]; then
    declare -n key_array=keys128
  elif [ $bits -eq 192 ]; then
    declare -n key_array=keys192
  else
    declare -n key_array=keys256
  fi

  for plaintext_index in "${!plaintexts[@]}"; do
    plaintext=${plaintexts[$plaintext_index]}
    for key_index in "${!key_array[@]}"; do
      key=${key_array[$key_index]}
      assert 'echo "$plaintext" | ${baesh} -K "$key" -b $bits -m ecb -o raw | openssl enc -aes-${bits}-ecb -d -K "$key"' "$plaintext"
      assert 'echo "$plaintext" | openssl enc -aes-${bits}-ecb -K "$key" | ${baesh} -K "$key" -d -b ${bits} -m ecb -o raw | cat' "$plaintext"
      assert_end "ecb ${bits} bits, known text ${plaintext_index}, key ${key_index}, raw output"

      # check base64 output
      IFS= read -r -d '' openssl_output < <(printf "$plaintext" | openssl enc -aes-${bits}-ecb -K "$key" -base64)
      assert 'printf "$plaintext" | ${baesh} -K "$key" -b ${bits} -m ecb -o base64' "$openssl_output"
      assert_end "ecb ${bits} bits, known text ${plaintext_index}, key ${key_index}, base64 output"
    done
  done

  if [ "$BAESH_FULL_TEST" = "1" ]; then
    dd if=/dev/urandom bs=1 count=$random_bytes status=none > $other_file
    for key_index in "${!key_array[@]}"; do
      key=${key_array[$key_index]}
      
      ${baesh} -K "$key" -b ${bits} -m ecb -o raw < $other_file > $baesh_file
      openssl enc -aes-${bits}-ecb -K "$key" -in $other_file > $openssl_file
      assert_raises "diff $baesh_file $openssl_file" 0
      assert_end "ecb ${bits} bits, random input, key ${key_index}, raw output"

      IFS= read -r -d '' openssl_output < <(openssl enc -aes-${bits}-ecb -K "$key" -in $other_file -base64)
      assert '${baesh} -K "$key" -b ${bits} -m ecb -o base64 < $other_file' "$openssl_output"
      assert_end "ecb ${bits} bits, random input, key ${key_index}, base64 output"
    done
  fi
done


##### non-ECB encryption tests ########################
for mode in cbc cfb ofb ctr; do
  for bits in 128 192 256; do

    if [ $bits -eq 128 ]; then
      declare -n key_array=keys128
    elif [ $bits -eq 192 ]; then
      declare -n key_array=keys192
    else
      declare -n key_array=keys256
    fi

    for plaintext_index in "${!plaintexts[@]}"; do
      plaintext=${plaintexts[$plaintext_index]}
      for key_index in "${!key_array[@]}"; do
        key=${key_array[$key_index]}
        for iv_index in "${!IVs[@]}"; do
          iv=${IVs[$iv_index]}
          assert 'echo "$plaintext" | ${baesh} -I "$iv" -K "$key" -b $bits -m $mode -o raw | openssl enc -aes-${bits}-${mode} -d -iv "$iv" -K "$key"' "$plaintext"
          assert 'echo "$plaintext" | openssl enc -aes-${bits}-${mode} -iv "$iv" -K "$key" | ${baesh} -K "$key" -I "$iv" -d -b ${bits} -m ${mode} -o raw | cat' "$plaintext"
          assert_end "${mode} ${bits} bits, known text ${plaintext_index}, key ${key_index}, IV ${iv_index}, raw output"

          # check base64 output
          IFS= read -r -d '' openssl_output < <(printf "$plaintext" | openssl enc -aes-${bits}-${mode} -iv "$iv" -K "$key" -base64)
          assert 'printf "%s" "$plaintext" | ${baesh} -K "$key" -I "$iv" -b ${bits} -m ${mode} -o base64' "$openssl_output"
          assert_end "${mode} ${bits} bits, known text ${plaintext_index}, key ${key_index}, IV ${iv_index}, base64 output"
        done
      done
    done


    if [ "$BAESH_FULL_TEST" = "1" ]; then
      dd if=/dev/urandom bs=1 count=$random_bytes status=none > $other_file
      for key_index in "${!key_array[@]}"; do
        key=${key_array[$key_index]}
        for iv_index in "${!IVs[@]}"; do
          iv=${IVs[$iv_index]}
          ${baesh} -K "$key" -I "$iv" -b ${bits} -m ${mode} -o raw < $other_file > $baesh_file
          openssl enc -aes-${bits}-${mode} -iv "$iv" -K "$key" -in $other_file > $openssl_file
          assert_raises "diff $baesh_file $openssl_file" 0
          assert_end "${mode} ${bits} bits, random input, key ${key_index}, IV ${iv_index}, raw output"

          IFS= read -r -d '' openssl_output < <(openssl enc -aes-${bits}-${mode} -iv "$iv" -K "$key" -in $other_file -base64)
          assert '${baesh} -K "$key" -I "$iv" -b ${bits} -m ${mode} -o base64 < $other_file' "$openssl_output"
          assert_end "${mode} ${bits} bits, random input, key ${key_index}, IV ${iv_index}, base64 output"
        done
      done
    fi
  done
done

rm -f $other_file $baesh_file $openssl_file
