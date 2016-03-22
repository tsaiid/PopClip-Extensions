curl -s -L $POPCLIP_TEXT | grep og:image\" | sed -E 's/^.+(http.+)\".+$/\1/' | xargs -n 1  -I {} sh -c "open {}"
