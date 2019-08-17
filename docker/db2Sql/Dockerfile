FROM ibmcom/db2

HEALTHCHECK --interval=5s --start-period=3s CMD ./opt/ibm/db2/V11.5/bin/db2 "connect to FAKEDB" && ./opt/ibm/db2/V11.5/bin/db2 "SELECT 1 FROM SYSIBM.SYSDUMMY1" || exit 1