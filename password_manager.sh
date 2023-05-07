#!/bin/bash

PASSWORD_FILE="password_data.txt"

function add_password {
    echo "サービス名を入力してください："
    read service_name
    echo "ユーザー名を入力してください："
    read username
    echo "パスワードを入力してください："
    read password

    echo "${service_name},${username},${password}" >> $PASSWORD_FILE
    echo "パスワードの追加は成功しました。"
}

function get_password {
    echo "サービス名を入力してください："
    read service_name
    result=$(grep "^${service_name}," $PASSWORD_FILE)

    if [ -z "$result" ]; then
        echo "そのサービスは登録されていません。"
    else
        IFS=',' read -ra data <<< "$result"
        echo "サービス名：${data[0]}"
        echo "ユーザー名：${data[1]}"
        echo "パスワード：${data[2]}"
    fi
}

while true; do
    echo "パスワードマネージャーへようこそ！"
    echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："
    read input

    case $input in
        "Add Password")
            add_password
            ;;
        "Get Password")
            get_password
            ;;
        "Exit")
            echo "Thank you!"
            exit 0
            ;;
        *)
            echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
            ;;
    esac
done
