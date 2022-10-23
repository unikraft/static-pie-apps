
# PostgreSQL
## Psql

Use the `build.sh` script to download and build `psql`.
The resulting `psql` binary is a static PIE executable loadable using the Unikraft ELF Loader. 
Launching psql with run_elf_loader, it is required to launch with the `-U <username>` parameter, because Unikraft does not provide a default user to `psql`.

# Postgresql executables which need to be checked before they can be used


- initdb
- scripts
- pgbench
- pg_dump
- pg_test_timing
- pg_checksums
- pgevent
- pg_upgrade
- pg_amcheck
- pg_config
- pg_resetwal
- pg_verifybackup
- pg_archivecleanup
- pg_controldata
- pg_rewind
- pg_waldump
- pg_basebackup
- pg_ctl
- pg_test_fsync

