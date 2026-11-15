# function zt(){
#   zathura $@ &!
# }

# Create a directory and cd into it
function mk (){ 
    if [[ ! -d "$1" ]];then
        command mkdir -p /tmp/new_2/$RANDOM && builtin cd $_
    else
        builtin cd "$1"
    fi
}

function mkrand(){
    # LISENCE: see tsoding/jim/examples/fruits.h
    fruits=(
        "apple" "apricot" "avocado" "banana" "bilberry" "blackberry"
        "blackcurrant" "blueberry" "boysenberry" "currant" "cherry"
        "cherimoya" "chico-fruit" "cloudberry" "coconut" "cranberry"
        "cucumber" "custard-apple" "damson" "date" "dragonfruit" "durian"
        "elderberry" "feijoa" "fig" "goji-berry" "gooseberry" "grape"
        "raisin" "grapefruit" "guava" "honeyberry" "huckleberry"
        "jabuticaba" "jackfruit" "jambul" "jujube" "juniper-berry" "kiwano"
        "kiwifruit" "kumquat" "lemon" "lime" "loquat" "longan" "lychee"
        "mango" "mangosteen" "marionberry" "melon" "cantaloupe" "honeydew"
        "watermelon" "miracle-fruit" "mulberry" "nectarine" "nance" "olive"
        "orange" "blood-orange" "clementine" "mandarine" "tangerine"
        "papaya" "passionfruit" "peach" "pear" "persimmon" "physalis"
        "plantain" "plum" "prune" "pineapple" "plumcot" "pomegranate"
        "pomelo" "purple-mangosteen" "quince" "raspberry" "salmonberry"
        "rambutan" "redcurrant" "salal-berry" "salak" "satsuma" "soursop"
        "star-fruit" "solanum-quitoense" "strawberry" "tamarillo"
        "tamarind" "ugli-fruit" "yuzu"
    )

    fruit=$(
        for f in "${fruits[@]}"; do echo "$RANDOM $f"; done | sort -n | cut -d' ' -f2 | {
            while read -r f; do
                fruit="$f"
                if ! ls /rand 2>/dev/null | grep -q "^$f-"; then
                    # @dupplicated
                    # we decide to use the date: MMDD if already taken we use rand
                    break
                fi
            done
            echo "$fruit"
        }
    )

    # @dupplicated
    # we decide to use the date: MMDD if already taken we use rand
    dir="/rand/${fruit}-${RANDOM}/"
    if [[ ! -d "$dir" ]];then
      command mkdir -p "$dir"
    fi
    builtin cd "$dir"
}
