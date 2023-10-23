# 💖 Chào mọi người đến với service website đặt bàn nhà hàng💖
Đây là dự án đặt bàn ăn nhà hàng trực tuyến được xây dựng bằng API.NET CORE WEB API, sử dụng các công nghệ mới nhất để mang lại trải nghiệm tốt nhất cho người dùng. Trang web có tính năng thanh toán trực tuyến sử dụng Stripe, cho phép khách hàng thanh toán dễ dàng và an toàn. Sử dụng các famework có sẳn như JWT Bearer, Identity, Identity Authentication,.. Hy vọng bạn sẽ hài lòng với dự án của tôi.

# Đầu tiên để chạy được dự án, mọi người cần phải:
- Cài trước Visual Studio
- Đã cài .NET 6 và SDK .NET 6
- Nếu chưa yêu cầu coi video sau và làm theo để cài đặt
Video cài : https://youtu.be/AC5UWby16sg?si=4PMC_tRYkaHFLVuG
- Kiểm tra đã cài Mysql Workbench chưa, nếu chưa làm theo video dưới để cài
Video cài : https://youtu.be/gqjs9Ou4UIs?si=tPCHv8t1AT_lq4gn

# Các bước chạy project
1 : Tải project:
```
$ Bật Git Bash Here ở thư mục chứa và nhập lệnh:
```
git clone https://github.com/NguyenLuan0213/Restaurant.git
```
- Và chờ tải về hoàng tất

2 : Tạo cơ sở dữ liệu(data base)
- Bật Mysql Mysql Workbench
- Tạo một kết nối Mysql Connections với tên là demo, post: 3306, Hostname: 127.0.0.1, Username: root, Password: 123456, rồi ấn Ok
- Tạo một schema in the connected service với tên là 
```
restaurant_demo
```
- Phía dưới phần Charset/Collation, cái đầu chọn utf8mb4, cái sau tiếp là utf8mb4-unicode
- Rồi ấn Apply, nó hiện một cái bảng tiếp tục ấn Apply, ấn Finish
- Chọn Server, chọn Data Import, chọn tiếp Import from Self-Contained File, ấn dấu 3 ... cùng hàng đó, vào thư mục tải xuống lúc nãy chọn file có tên là 
```
21-10-2023.sql
```
- Sau đó phần Default Target Schema chọn cái restaurant_demo mới tạo lúc nãy
- Rồi ấn Start Import
- Kiểm ra xem các bảng đã có dữ liệu chưa và hoàng tất bước tạo data

3 : Mở thư mục tải bằng github vừa nãy, mở file Restaurant.sln
- Nó sẽ hiện lên visual studio, bạn nên chờ một chút để visual load hết các framework và dự án

4 : Nhấn run để chạy service

# Phần Kết

- Bạn sẽ thấy toàn bộ các API của dự án dùng để chạy data cho Website khách hàng, cũng như là Website Admin

Cảm ơn bạn đã kiểm tra dự án của tôi! Nếu bạn có bất kỳ ý kiến ​​​​hoặc phản hồi nào, vui lòng liên hệ với tôi. Tôi luôn mong nhận được ý kiến ​​từ mọi người để hoàn thiện dự án của mình hơn.. ❤️‍🔥❤️‍🔥




