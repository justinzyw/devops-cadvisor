FROM google/cadvisor:v0.27.1
#the lastest version (0.25) has an issue of "unable to connect to Rkt api service"

RUN apk -U add findutils
