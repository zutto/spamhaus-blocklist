# spamhaus ip blocklist updater

This is a tiny tool for automating the update process of nginx blocklist.

usage:
./block.sh /desti/nation/file.conf

and then inside http {} directive:
"include /desti/nation/file.conf;"
to include the denied ip blocks.


--
You can also edit the block.sh and ignore first argument.

