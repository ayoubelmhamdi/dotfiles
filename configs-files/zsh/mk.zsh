# function zt(){
#   zathura $@ &!
# }

# Create a directory and cd into it
function mk (){ 
    if [[ ! -d "$1" ]];then
      command mkdir -p "$1"
    fi
    builtin cd "$1"
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

    fruit="${fruits[RANDOM % ${#fruits[@]}]}"

    dir="/rand/$fruit-$RANDOM/"
    if [[ ! -d "$dir" ]];then
      command mkdir -p "$dir"
    fi
    builtin cd "$dir"
}
