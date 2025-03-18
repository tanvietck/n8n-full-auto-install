# N8N Full Auto Install Script 🚀

## Giới thiệu
Script tự động cài đặt toàn bộ hệ thống N8N trên Ubuntu (sử dụng Docker, Nginx và SSL).  
Chỉ cần chạy một dòng lệnh duy nhất, hệ thống sẽ:
- Cài đặt Docker & Docker Compose
- Khởi tạo và chạy n8n container với bảo mật Basic Auth
- Tạo reverse proxy thông qua Nginx
- Cấu hình HTTPS tự động với Let's Encrypt

---

## Yêu cầu hệ thống
- Ubuntu 20.04+ (khuyến nghị 22.04)
- Tài khoản root hoặc quyền sudo
- Một domain đã trỏ về IP server

---

## Hướng dẫn sử dụng

### Bước 1: Chạy script tự động
```bash
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/tanvietck/n8n-full-auto-install/2a1f921244bddfc8d3830ff4b99df12cca67ca1a/n8n-full-auto-install.sh)"
```
### Bước 2: Nhập thông tin khi được yêu cầu:
- Mật khẩu admin cho n8n
- Domain trỏ về server (ví dụ: `n8n.yourdomain.com`)

---

## Thông tin sau khi cài đặt
- Truy cập: `https://yourdomain.com`
- Tài khoản: **admin**
- Mật khẩu: do bạn nhập khi chạy script

---

## Tác giả
**Minh Anh Cloud Team**  
📧 Liên hệ: hotrosp1@gmail.com  
🌐 Website: [https://minhanhcloud.vn](https://minhanhcloud.vn)  

---

## Góp ý / hỗ trợ
Nếu gặp bất kỳ lỗi nào trong quá trình sử dụng, hãy mở issue hoặc liên hệ trực tiếp qua email!

❤️ Chúc bạn thành công!

