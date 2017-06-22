# fleet-commander-freeipa-environment
Scripts for creating a testing Fedora environment for Fleet Commander with FreeIPA

## Steps to create environment

### FreeIPA Master server
1. Set machine network to static IP address and set as DNS the server IP address itself and 8.8.8.8
2. Copy ipamaster.sh script to machine
3. Execute ipamaster.sh as root
4. Ask questions about IPA server configuration
    * Leave default values for machine and domain names
    * Set domain admin password
    * Set admin user password
    * Answer NO to setup DNS forwarders
    * Answer YES to search for missing reverse zones
    * Answer yes to add every reverse resolution zone shown and keep the default zone names
    * Answer yes to reverse zome
    * Answer yes to use that values and wait for configuration to finish
  
### Fleet commander admin machine
1. Set machine network to static IP address and set as DNS the FreeIPA Master IP address itself and 8.8.8.8
2. Copy fcadmin.sh script to machine
3. Execute fcadmin.sh as root
4. Enter the IPA Master IP address when requested

### Fleet commander client machine
1. Set machine network to static IP address and set as DNS the FreeIPA Master IP address itself and 8.8.8.8
2. Copy fcclient.sh script to machine
3. Execute fcclient.sh as root
4. Enter the IPA Master IP address when requested

### Fleet commander template machine
1. Copy template.sh script to machine
2. Execute template.sh as root

