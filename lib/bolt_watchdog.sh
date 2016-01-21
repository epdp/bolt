#!/usr/bin/env bash

# esto es ejecutado por el cron cada x minutos y debe comprobar que el wrapper está vivo
# si no, debe reiniciar el wrapper

# on crontab:
#    * * * * * /bin/bash -l -c '/path/to/watchdog/bolt_watchdog.sh /path/to/app'

# on bundler environments there should be a stub calling this script
#
#   #!/usr/bin/env bash
#   cd `dirname $0`
#   $(bundle show bolt)/lib/bolt_watchdog.sh "$(pwd)"
#

app=$1
lib=$(cd `dirname $0` && pwd)
logs="$app/log/flagella.log"
flagellum="bolt.rb"
command="$lib/$flagellum"
pids_folder="$HOME/flagella/bolt/pids"
mkdir -p $pids_folder > /dev/null

. $lib/shell_helpers.sh

# comprobar que solo se esta ejecutando un proceso flagelo, y si no saca el hacha
check_pids_folder_for_uniqueness "$pids_folder" >> $logs

#echo "------ CARNAGE: $CARNAGE   --------   FLAGELLUM_PROCESS_COUNT: $FLAGELLUM_PROCESS_COUNT " >> $logs

# comprobar flagelo
[ $FLAGELLUM_PROCESS_COUNT -gt 0 ] && [ $CARNAGE -eq 0 ] && exit 0

# arrancar flagelo
test -s "$HOME/.bash_profile" && source "$HOME/.bash_profile"
test -s "$HOME/.bashrc" && source "$HOME/.bashrc"
export CURRENT_ENV=production
cd $app
bundle exec ruby $command &>> $logs &
wait_for_process spawn $command 30
[ $? -ne 0 ] && echo "Exception: Could not spawn '$command'." | tee -a $logs && exit 1

echo "--- $(date) --- '$command' ha sido iniciado." >> $logs
exit 0
