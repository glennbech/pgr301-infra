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
`Error: Error waiting to create Service: resource is in failed state "Ready:False", message: Service teardown complete.
Releasing state lock. This may take a few moments...`

Og denne: 

`Error: Error waiting to create Service: resource is in failed state "Ready:False", message: Cloud Run error: Container failed to start. Failed to start and then listen on the port defined by the PORT environment variable. Logs for this revision might contain more information.

Logs URL:
https://console.cloud.google.com/logs/viewer?project=exam1pg301&resource=cloud_run_revision/service_name/cloudrun-srv/revision_name/cloudrun-srv-dpcnx&advancedFilter=resource.type%3D%22cloud_run_revision%22%0Aresource.labels.service_name%3D%22cloudrun-srv%22%0Aresource.labels.revision_name%3D%22cloudrun-srv-dpcnx%22
`

(Altså noen ganger den ene, og noen ganger den andre. Har ikke fått løst dem.)

Men image skal være deployet til Cloud Run:
https://drive.google.com/file/d/14r0aqN_YJYJhascZDNK_0IpTGTAQXAeM/view?usp=sharing



