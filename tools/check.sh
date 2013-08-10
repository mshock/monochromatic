#!/bin/bash

http=http://validator.w3.org/check
uri=blog.z3bra.org
charset=utf-8
doctype=Inline
profile=css3


check="${http}?uri=${uri}&charset=${charset}&$doctype=${doctype}"

if [[ -n "$(curl -s "$check"  | grep -o 'Passed')" ]]; then
    echo -e "\033[1;32mHTML validated!\033[0m"
else
    echo -e "\033[1;31mHTML not valid!\033[0m\ncheck $check"
fi

http=http://jigsaw.w3.org/css-validator/validator
check="${http}?uri=${uri}&profile=${profile}"

if [[ -n "$(curl -s "$check"  | grep -o 'No Error')" ]]; then
    echo -e "\033[1;32mCSS  validated!\033[0m"
else
    echo -e "\033[1;31mCSS  not valid!\033[0m\ncheck $check"
fi
