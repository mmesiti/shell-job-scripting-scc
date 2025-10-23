
cleanup(){
  echo "Cleanup before interrupt and exit"
  exit 0
}

(
trap "cleanup" SIGINT

while true
do
  sleep ${SLEEP_INTERVAL:-1}
done
) & 

sleep 5
kill -SIGINT %1 # Sending the signal to the process in the background.
echo "Sent SIGINT at $SECONDS seconds"
wait
echo "Subprocess terminated at $SECONDS seconds"

