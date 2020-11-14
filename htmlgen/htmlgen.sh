#!/usr/bin/env bash

extensions=(mp4 webm)
MIME=
TITLE=
FORCE=
COUNTER=1

while getopts 'f' OPTION; do
	case "$OPTION" in
		f)
			echo Regenerating all html files...
			rm *.html
			FORCE=true
			;;
	esac
done
shift "$(($OPTIND-1))"

for extension in "${extensions[@]}"
do
	case $extension in
		mp4)
			MIME="video/mp4"
			;;
		webm)
			MIME="video/webm"
			;;
		*)
			echo "Unknown extension"
			exit 1
			;;
	esac

	readarray -d '' rawvids < <( find . -name "*.${extension}" -print0 )
	readarray -t videofiles < <(for a in "${rawvids[@]}"; do echo "$a"; done | sort -V)

	for videopath in "${videofiles[@]}"
	do

		echo $videopath
		html_path="${videopath%.${extension}}.html"
		html_path="${html_path#'./'}"


		if [[ ! -f "${html_path}"  ||  $FORCE == "true" ]]; then

			echo vidpath ${videopath}
			echo "html path is ${html_path}"

			TITLE="${videopath%.${extension}}"
			TITLE="${TITLE#'./'}"

			index=$(echo "${html_path}" | awk -F/ '{print $1}')
			echo Index is ${index}
cat <<EOF > "${html_path}"
<head>
	<link href="https://vjs.zencdn.net/7.8.4/video-js.css" rel="stylesheet" />


<body>
	<video
		id="vid"
		class="video-js vjs-fill vjs-big-play-centered"
		controls
		preload=auto
		data-setup='{ "playbackRates": [0.5, 1, 1.5, 2] }'
	>
	<source src='$(basename "${videopath}")' type="${MIME}" />
	</video>
	
	<script src="https://vjs.zencdn.net/7.8.4/video.js"></script>
</body>
</head>
EOF

			grep -q "${index}" index.html 2>/dev/null || echo -e "<a href='${index}.html'>${index}</a>\n<br>" >> "index.html"
			if [[ $DIR != $(dirname "${videopath}") ]]; then

				DIR=$(dirname "${videopath}")
				echo "<p>----------------------------------</p>" >> "${index}.html"
				COUNTER=1
				echo dir: $DIR
			fi
			grep -q "${html_path}" "${index}".html 2>/dev/null || echo -e "${COUNTER}- <a href='${html_path}'>${TITLE}</a>\n<br>" >> "${index}.html"
			COUNTER=$(($COUNTER +1))
		fi
	done

done

