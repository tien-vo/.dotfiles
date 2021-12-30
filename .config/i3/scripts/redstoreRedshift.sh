source ~/.config/i3/scripts/redshift.sh

if [ "$REDSHIFT_STATUS" = "on" ]; then
	redshift -O "$REDSHIFT_TEMP"
fi
