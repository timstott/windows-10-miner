setx GPU_FORCE_64BIT_PTR 0
setx GPU_MAX_HEAP_SIZE 100
setx GPU_USE_SYNC_OBJECTS 1
setx GPU_MAX_ALLOC_PERCENT 100
setx GPU_SINGLE_ALLOC_PERCENT 100

EthDcrMiner64.exe -epool eth-asia1.nanopool.org:9999 -ewal 0x18EB9cc4d02e1855b4f1D2c8777Be64b234d4E4b.buster/mining-rigs-cooperative@googlegroups.com -epsw x -dcoin sia -dpool stratum+tcp://sia-asia1.nanopool.org:7777 -dwal e51d669a8d5df110469215fd0daf40535dccf5f563259223821c039abfde52c9bd4aa443f5f8/buster/mining-rigs-cooperative@googlegroups.com -dpsw x -dcri 12 -ftime 3 -tstop 85 -tt 65 -fanmin 75 -fanmax 100 -cclock 1130 -mclock 2250 -cvddc 850 -mvddc 850
