apt install lynis -y
lynis audit system --report-file ./lynis.log | grep -e "WARNING" -e "SUGGESTION" -e "CRITICAL"