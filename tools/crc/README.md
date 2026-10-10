# FlashMe CRC utility

[中文说明](README.zh-cn.md)

<code>flashmecrc</code> is a small dependency-free C99 program used by the
FlashMe reconstruction Makefiles. Its source is retained so Linux and macOS
users can build a native executable; the Windows <code>flashmecrc.exe</code>
is built from the same source and may be checked in as a convenience binary.

Build it with:

~~~sh
make
~~~

The four supported modes are:

~~~text
flashmecrc crc32-official --image FILE --range-end N \
    --private-fill-start N --private-fill-end N --expected N [--write FILE]

flashmecrc crc16-flashme --image FILE --reference FILE --range-end N \
    --expected N [--write FILE]

flashmecrc crc16-check --image FILE --range-end N --expected N

flashmecrc crc16-record --image FILE --range-end N [--write FILE]
~~~

<code>crc32-official</code> calculates CRC-32/ISO-HDLC while virtually
filling the specified private range with <code>FF</code>. <code>crc16-flashme</code>
optionally compares a rebuilt image and a supplied reference. The reconstruction
Makefiles use <code>crc16-check</code> to compare a rebuilt image with the fixed
value read from its checked-in record; they never write a record. A mismatch is
reported as a non-fatal warning after the output image has been created. Without
<code>--write</code>, <code>crc16-record</code> only prints the current value.

The tool accepts any image length; every supplied CRC or virtual-fill range must
remain within that image.
