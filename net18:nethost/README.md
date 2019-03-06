# Kerberos Server
## @edt ASIX M11-SAD Curs 2018-19

**francs2/k18:sshd** Servidor SSHD *kerberitzat*. Servidor ssh que permet
  l'accés d'usuaris locals i usuaris locals amb autenticació kerberos. El
  servidor s'ha de dir sshd.edt.org.

Per fer que el servidor sshd sigui *kerberos aware* cal:

 * instal·lar.hi el paquet krb5-workstation.

 * copiar el fitxerd e configuració kerberos client */etc/krb5.conf*.

 * crear un principal al servidor kerberos coresponent al host sshd. En aquest cas concret es crea
  una entrada *host/sshd.edt.org*.

 * propagar aquest principal (de host)  al keytab del servidor sshd. Aquí s'utilitza un mecanisme 
  *pèssim*, des del client, desatesament, es connecta amb usuari i passwd (text pla) via *kadmin* al
  servidor kerberos i exporta les claus del principal *host/sshd.edt.org* via *ktadd*.

 * configurar el servidor sshd per permetre l'autenticació kerberos, cal modificar el fitxer de 
 configuració del servei */etc/ssh/sshd_config*:

```
# Kerberos options
KerberosAuthentication yes
KerberosTicketCleanup yes
```

Execució:
**$ docker run --rm  --name sshd.edt.org -h sshd.edt.org --network mynet -it  francs2/k18:sshd **

Comprovacio:
```
[local01@sshd ~]$ ssh user02@sshd.edt.org
The authenticity of host 'sshd.edt.org (172.18.0.3)' can't be established.
ECDSA key fingerprint is SHA256:wM+DVP4kF1LFsUFJ4pRA7p3w2bnDtK/g1a8kaPMxm94.
ECDSA key fingerprint is MD5:f4:bb:fe:22:cb:f1:21:1d:5d:86:8d:fd:3a:ec:b7:67.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'sshd.edt.org,172.18.0.3' (ECDSA) to the list of known hosts.
[user02@sshd ~]$

[local01@sshd ~]$ klist 
Ticket cache: FILE:/tmp/krb5cc_1000
Default principal: user02@EDT.ORG

Valid starting       Expires              Service principal
02/22/2019 11:08:56  02/23/2019 11:08:56  krbtgt/EDT.ORG@EDT.ORG  -> ta donat kerberos
02/22/2019 11:09:15  02/23/2019 11:08:56  host/sshd.edt.org@EDT.ORG  -> ssh ta dit si y et dona un tiket
```

