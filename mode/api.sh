#!/usr/bin/env bash
# /============================================Tạo API Application!!!==================================================\
# chú ý: việc tạo sẵn token trên cli hay curl sẽ không hoàn hảo nếu sử dụng WebGui bằng tay
# tao nguoi dung qua post va lay cookie
# curl -X POST 'http://localhost:8080/admin/config.php' \
#     -d 'action=setup_admin&username=admin&password1=admin&password2=admin&email=vudat412@gmail.com&system_ident=VoIP+Server&auto_module_updates=enabled&auto_module_security_updates=enabled&unsigned_module_emails=enabled&update_every=saturday&update_period=4to8' \
#     -c /var/www/html/cookieLogin.json
#     -c nếu muốn lưu lại cookie user
#  Chú ý : nếu ko sử dụng file mysql/30_init_db/run thì có thẻ áp dụng câu lệnh trên, câu lệnh này sẽ chạy khi container được thực thiện xong còn file init sẽ khởi tạo trực tiếp đồng thời  


# /============================================ Thiết lập Ngôn Ngữ qua POST ==================================================\
# thiet lap ngon ngu english
curl -X POST 'http://localhost:8080/admin/config.php' \
    -d 'username=admin&password=admin&oobeSoundLang=en&oobeGuiLang=en_US'
    
# /============================================ Curl POST Lấy Sesion Cookie ==================================================\
# gán biến cookie với cli ==> cli = command line 
# curl để kết nối thêm --silent sẽ khiên tốc độ reload nhanh hơn stderr cũng tương tự
# cú pháp cắt ghép: grep tìm -oP để loại bỏ ký tự trong cú pháp ta cho như bên dưới sẽ loại bỏ a->z và kèm số trước + awk sẽ cắt bỏ strings chuỗi gì đó như = tại từ thứ 2 
# tạo biến cookie tiện cắt chuỗi luôn :v
cookie="$(curl -X POST -v --silent http://localhost:8080/admin/config.php \
    -d 'username=admin&password=admin&oobeSoundLang=en&oobeGuiLang=en_US' --stderr - | grep expire | grep -oP 'PHPSESSID=([a-zA-Z0-90]+)' | awk -F "=" '{print $2}')"

# /============================================ Curl POST Tạo API Application ==========================================\
# đọc doc về Curl xGET 
# curl từ biến và gán tao key api_application 
# Cách 1: --data
curl -X POST 'http://localhost:8080/admin/ajax.php?module=api&command=add_application' \
    --header 'Referer: http://localhost:8080/admin/config.php?display=api' \
    --cookie "PHPSESSID=$cookie" \
    -d 'type=client_credentials&name=API&description=GRAPH+API&website=&redirect=&allowed_scopes=gql&user=' > /var/www/html/token.json
# Cách 2: --form 
curl -X POST 'http://localhost:8080/admin/ajax.php?module=api&command=add_application' \
    --header 'Referer: http://localhost:8080/admin/config.php?display=api' \
    --cookie "PHPSESSID=$cookie" \
    --form 'type="client_credentials"' \
    --form 'name="API2"' \
    --form 'description="GRAPH+API"' \
    --form 'allowed_scopes="gql"' \
    --form 'website=""' \
    --form 'redirect=""' \
    --form 'user=""' \
    > /var/www/html/token.json

# /============================================ Curl POST Tạo API GRAPHQL ==========================================\
# sử dụng 2 key để gen khóa
# Chú ý : khóa khóa trên WebGUI khác với khóa trong DBS (Databases) 
# Khóa trên WebGui sẽ ở dạng ban đầu sha256 còn khóa trong dbs sẽ là khóa cuối cùng, khóa sha256 1 chiều
# cắt chuỗi và gán biến client_id 
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
http://localhost:8080/admin/api/api/token >> /var/www/html/tokenAPI.json
# ip = localhost, map ra bên ngoài với cổng 8080 nhưng container vẫn sd 80 làm mặc định
fwconsole reload