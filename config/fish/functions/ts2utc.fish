function ts2utc
  set -l ts $argv[1]
	TZ="UTC" date -d @$ts -u "+%Y-%m-%d  %H:%M:%S  %Z (%:z)"
end
