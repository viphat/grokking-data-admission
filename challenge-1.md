### Propose a solution for challenge 1

Chưa hiểu kỹ về đề bài 1 này lắm nên mình chỉ đề xuất cách làm theo những gì mình hiểu như sau:

1. Sắp xếp và lưu trữ file vào thư mục theo từng ngày ~ mỗi ngày là một thư mục và files của ngày nào thì đặt đúng thư mục của ngày đó. Tên thư mục sẽ là unix_timestamp của ngày cụ thể (lấy beginning of day làm chuẩn).

2. Khi nhận được yêu cầu extract dữ liệu theo time range cụ thể thì phân tích time range đó, ta biết sẽ phải vào lục lọi trong những thư mục nào và sẽ đọc lần lượt files trong những thư mục đó.

3. Vì nội dung File theo format comma seperated csv nên dùng thư viện chuyên dùng xử lý CSV cho tốc độ đọc khá nhanh. Vì file khá nặng nên để tối ưu tốc độ xử lý thì nên read by lines.

4. Khi read line by line, đọc thấy Book mới thì tạo file mới cho Book đó và lấy nội dung của row đó vào file vừa tạo. Nếu là Book đã có (đã tồn tại một file với tên file là tên book) thì append row đó vào file tương ứng. 
