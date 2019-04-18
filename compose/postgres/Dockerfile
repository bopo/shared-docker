FROM postgres:alpine

# add backup scripts
ADD backup.sh /usr/local/bin/backup
ADD restore.sh /usr/local/bin/restore
ADD backups.sh /usr/local/bin/backups

# make them executable
RUN chmod +x /usr/local/bin/restore
RUN chmod +x /usr/local/bin/backups
RUN chmod +x /usr/local/bin/backup
