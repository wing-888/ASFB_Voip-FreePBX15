#!/usr/bin/env bash
# tao nguoi dung qua post va lay cookie
curl -X POST 'http://192.168.1.25:8080/admin/config.php' \
    -d 'action=setup_admin&username=admin&password1=admin&password2=admin&email=vudat412@gmail.com&system_ident=VoIP+Server&auto_module_updates=enabled&auto_module_security_updates=enabled&unsigned_module_emails=enabled&update_every=saturday&update_period=4to8' \
    -c /var/www/html/cookieLogin.json 
    # -c nếu muốn lưu lại cookie user 
# thiet lap ngon ngu english
curl -X POST 'http://192.168.1.25:8080/admin/config.php' \
    -d 'username=admin&password=admin&oobeSoundLang=en&oobeGuiLang=en_US'
# tạo biến cookie tiện cắt chuỗi luôn :v
cookie="$(curl -X POST -v --silent http://192.168.1.25:8080/admin/config.php \
    -d 'username=admin&password=admin&oobeSoundLang=en&oobeGuiLang=en_US' --stderr - | grep expire | grep -oP 'PHPSESSID=([a-zA-Z0-90]+)' | awk -F "=" '{print $2}')"
# curl từ biến và gán tao key api_application 
curl -X POST 'http://192.168.1.25:8080/admin/ajax.php?module=api&command=add_application' \
    --header 'Referer: http://192.168.1.25:8080/admin/config.php?display=api' \
    --cookie "PHPSESSID=$cookie" \
    -d 'type=client_credentials&name=API&description=GRAPH+API&website=&redirect=&allowed_scopes=gql&user=' > /var/www/html/token.json
# cắt chuỗi client_id 
clientID="$(awk -F ":" '{print $5}' /var/www/html/token.json | cut -d, -f1 | cut -d '"' -f2)"
echo $clientID
# cắt chuỗi client_secret
clientSC="$(awk -F ":" '{print $6}' /var/www/html/token.json | cut -d, -f1 | cut -d '"' -f2)"
echo $clientSC
# Tạo Token API GRAPHQL 
curl -X POST \
-H "Accept:*/*" \
-H "Content-Type: application/json" \
-w "\n" \
-d '{"client_id":"'"$clientID"'","client_secret":"'"$clientSC"'","grant_type":"'"client_credentials"'","scope":"'"gql"'"}' \
http://192.168.1.25:8080/admin/api/api/token >> /var/www/html/tokenAPI.json
# chú ý: ko dc thay đổi nội dung bên trên do fix cứng 1 chiều
fwconsole reload