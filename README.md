# Pg301-exam-infrastructure

Cloud Run og Container Registry må være satt opp i prosjektet.

Sett opp en ny service account.
Gi den rollene: 

    * Cloud Run Service Agent.
    * Google Storage Admin.
    * Container Reistry Service Agent.

Last ned en key for service accounten og legg den i root.
Kall den for exam1pg301.json.
Kryptér den: 
`travis encrypt-file --pro exam1pg301.json --add`

(fjern "openssl aes-256-cbc..." som er der fra før  )

Krypter logz.io-token og url:

`travis encrypt --pro LOGZ_TOKEN=[Logz.io token]> --add`
`travis encrypt --pro LOGZ_URL=[Logz.io URL for Logz.io] --add`

Det må lages en ny bucket. 
Gå til Storage -> browser i valgmenyen i GCP.
Legg deretter navnet på bucket i provider.tf

    terraform {
     backend "gcs" {
        bucket = "[legg inn navnet på bucket her]"
        prefix = "terraformstate"
        credentials = "exam1pg301.json"
     }
    } 

##### --> push til master


##KOMMENTARER:

Får denne feilen i travis:

`Error: Error waiting to create Service: resource is in failed state "Ready:False", 
message: Cloud Run error: Container failed to start. Failed to start and then 
listen on the port defined by the PORT environment variable. Logs for this 
revision might contain more information. 
    Logs URL:
    1144https://console.cloud.google.com/logs/viewer?project=exam1pg301&resource=cloud_run_revision/service_name/cloudrun-srv/revision_name/cloudrun-srv-gzq5k&advancedFilter=resource.type%3D%22cloud_run_revision%22%0Aresource.labels.service_name%3D%22cloudrun-srv%22%0Aresource.labels.revision_name%3D%22cloudrun-srv-gzq5k%22
`





Får også denne feilen når jeg kjører terraform apply lokalt:

Error: Error waiting to create Service: resource is in failed state "Ready:False", message: Cloud Run error: Container failed to start. Failed to start and then listen on the port defined by the PORT environment variable. Logs for this revision might contain more information.

Logs URL:
https://console.cloud.google.com/logs/viewer?project=exam1pg301&resource=cloud_run_revision/service_name/cloudrun-srv/revision_name/cloudrun-srv-r79fx&advancedFilter=resource.type%3D%22cloud_run_revision%22%0Aresource.labels.service_name%3D%22cloudrun-srv%22%0Aresource.labels.revision_name%3D%22cloudrun-srv-r79fx%22
Har ikke fått løst dette. Kompilert med java 11 og kjørt med java 8. Er nok noe med docker.


`"Exception in thread "main" java.lang.UnsupportedClassVersionError: no/kristiania/exam/ExamApplication has been compiled by a more recent version of the Java Runtime (class file version 55.0), this version of the Java Runtime only recognizes class file versions up to 52.0
	at java.lang.ClassLoader.defineClass1(Native Method)
	at java.lang.ClassLoader.defineClass(ClassLoader.java:763)
	at java.security.SecureClassLoader.defineClass(SecureClassLoader.java:142)
	at java.net.URLClassLoader.defineClass(URLClassLoader.java:468)
	at java.net.URLClassLoader.access$100(URLClassLoader.java:74)
	at java.net.URLClassLoader$1.run(URLClassLoader.java:369)
	at java.net.URLClassLoader$1.run(URLClassLoader.java:363)
	at java.security.AccessController.doPrivileged(Native Method)
	at java.net.URLClassLoader.findClass(URLClassLoader.java:362)
	at java.lang.ClassLoader.loadClass(ClassLoader.java:424)
	at org.springframework.boot.loader.LaunchedURLClassLoader.loadClass(LaunchedURLClassLoader.java:151)
	at java.lang.ClassLoader.loadClass(ClassLoader.java:357)
	at java.lang.Class.forName0(Native Method)
	at java.lang.Class.forName(Class.java:348)
	at org.springframework.boot.loader.MainMethodRunner.run(MainMethodRunner.java:46)
	at org.springframework.boot.loader.Launcher.launch(Launcher.java:107)
	at org.springframework.boot.loader.Launcher.launch(Launcher.java:58)
	at org.springframework.boot.loader.JarLauncher.main(JarLauncher.java:88)`