[program:gomeet-service-name]
command=/opt/gomeet-examples/bin/gomeet-service-name serve --address ":gomeet-service-port" gomeet-service-opts
process_name=gomeet-service-name%(process_num)02d
autostart=true
autorestart=true
user=gomeet
stdout_logfile_maxbytes=1MB
stdout_logfile_backups=3
startretries=2147483647
numprocs=1
