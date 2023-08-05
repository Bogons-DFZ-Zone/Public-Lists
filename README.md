# Bad Actor --- Pathvector Bogon config for V6.3.0 and up
## "Crowdsourced Internet asshole and criminal removal"
This repository contains a list of known bad actors for which you can utilize in a Pathvector.io bogons list. 

Add and/or delete entries you think are wrong, and submit a pull request for review.

`blocklist-for-pathvector.txt` accepts both ASN and prefix entries, while `bogon-asns.yaml` only accepts ASN entries. If adding an ASN entry to either of these files, please add an equivalent entry to the other file. Please keep this in mind when contributing to ensure nothing gets missed.

The raw GitHub URL for `blocklist-for-pathvector.txt` can be added to the root section of the `pathvector.yml` configuration file by specifying it under the `blocklist-urls:` parameter. This will block all traffic to and from the networks specified within the blocklist.
