#! /bin/sh
# chkconfig: 345 99 10
case "$1" in
  start)
    # Executes auto start script
    sh /usr/local/share/yate/scripts/autostart.sh
    ;;
  *)
    ;;
esac
exit 0
