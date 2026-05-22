# SportShop

SportShop là ứng dụng bán đồ thể thao dùng Spring Boot và JSP. Dự án có
giao diện mua hàng cho khách, trang quản trị cho admin, REST API sản phẩm,
quản lý giỏ hàng, đặt hàng, voucher, thanh toán VNPay và đăng nhập Google.

## Chức năng chính

- Xem trang chủ, danh sách sản phẩm, lọc sản phẩm và chi tiết sản phẩm.
- Đăng ký, đăng nhập bằng tài khoản nội bộ và Google OAuth2.
- Quản lý hồ sơ người dùng và ảnh đại diện.
- Thêm sản phẩm vào giỏ, checkout, áp dụng voucher và xem lịch sử đơn hàng.
- Thanh toán CASH hoặc VNPay.
- Admin quản lý user, sản phẩm, category, brand, voucher và trạng thái đơn.
- Dashboard admin thống kê user active, đơn hàng, sản phẩm và doanh thu.
- REST endpoint đọc sản phẩm tại `/api/products`.

## Công nghệ

- Java 17
- Spring Boot 3.3.13
- Spring MVC, JSP, JSTL
- Spring Security, OAuth2 Client, Spring Session JDBC
- Spring Data JPA, Hibernate
- MySQL cho runtime chính
- H2 cho test profile
- Maven

## Cấu trúc dự án

```text
src/main/java/com/n11/sportshop
  config/       MVC, security và login success handler
  controller/   controller client, admin và API
  domain/       entity, enum và DTO
  repository/   Spring Data repository và query riêng
  service/      nghiệp vụ sản phẩm, user, cart, order, VNPay

src/main/resources
  application.properties
  data.sql

src/main/webapp
  WEB-INF/view/ JSP client và admin
  resources/    CSS, JS, image, font và SCSS
```

## Yêu cầu môi trường

Cần có:

1. JDK 17 trở lên.
2. MySQL đang chạy local.
3. Maven hoặc dùng Maven Wrapper có sẵn trong repo.

Cấu hình mặc định trong `application.properties` dùng:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/sportshop
spring.datasource.username=root
```

Tạo database trước khi chạy app:

```sql
CREATE DATABASE sportshop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

## Cấu hình secret

Ứng dụng đọc secret từ file `.env` ở thư mục gốc. File này đã nằm trong
`.gitignore`.

Tạo file `.env` từ mẫu:

```powershell
Copy-Item .env.example .env
```

Hoặc trên shell Unix:

```bash
cp .env.example .env
```

Cập nhật giá trị thật trong `.env`:

```properties
MYSQL_PASSWORD=your_mysql_password
VNPAY_HASH_SECRET=your_vnpay_hash_secret
GOOGLE_CLIENT_SECRET=your_google_client_secret
```

Không commit `.env`. Client id Google, VNPay endpoint, VNPay return URL và
datasource host/user hiện đang nằm trong `application.properties`.

## Chạy local

Trên Windows:

```powershell
.\mvnw.cmd spring-boot:run
```

Trên Unix:

```bash
./mvnw spring-boot:run
```

Sau khi app start, mở:

- Client UI: `http://localhost:8080`
- Login: `http://localhost:8080/login`
- Admin area: `http://localhost:8080/admin`
- Product API: `http://localhost:8080/api/products`

Admin area yêu cầu tài khoản có role `ADMIN`.

## Tạo dữ liệu ban đầu

`src/main/resources/data.sql` có seed cho role, category, brand, product và
voucher `WELCOME10`.

Với MySQL, SQL init đang không bật mặc định. Có thể import file này thủ công
vào database local hoặc bật tạm:

```properties
spring.sql.init.mode=always
```

`data.sql` có lệnh reset bảng, vì vậy cần kiểm tra database trước khi chạy
trên môi trường có dữ liệu cần giữ.

## Test và build

Chạy test:

```powershell
.\mvnw.cmd test
```

Test profile dùng H2, không cần MySQL local và không đọc secret thật trong
`.env`.

Build WAR:

```powershell
.\mvnw.cmd clean package
```

Nếu chỉ cần build nhanh và bỏ qua test:

```powershell
.\mvnw.cmd clean package -DskipTests
```

## Luồng nghiệp vụ chính

### Client

1. User xem sản phẩm tại `/products`.
2. Product form thêm item vào giỏ tại `/products/add-product-to-cart/{id}`.
3. Checkout tại `/cart/checkout` tạo `checkoutToken` một lần.
4. `/order/create` tạo đơn, khóa stock sản phẩm và áp dụng voucher nếu có.
5. Đơn CASH chuyển đến confirmation; đơn VNPay đi qua payment page và return
   URL.

### Admin

- `/admin` là dashboard.
- `/admin/user` quản lý user và gán voucher.
- `/admin/product` quản lý sản phẩm.
- `/admin/catalog` quản lý category, brand và voucher.
- `/admin/order` quản lý trạng thái đơn và xem chi tiết.

## Ghi chú kỹ thuật

- JSP view resolver map view name sang `/WEB-INF/view/*.jsp`.
- Spring Session JDBC tạo bảng session khi app khởi động nếu datasource hợp lệ.
- `OrderCleanupService` chạy mỗi 60 giây để xóa đơn VNPay hết hạn chưa thanh
  toán.
- Upload avatar và ảnh sản phẩm được xử lý trong `ImageService`.
- Swagger/OpenAPI UI không còn nằm trong dự án.

## Lưu ý khi deploy

- Dockerfile build WAR và chạy bằng `java -jar`.
- `docker-compose.yml` hiện phục vụ một image đã publish và có biến môi
  trường deployment riêng. Kiểm tra lại datasource, secret, security exclude
  và URL VNPay trước khi dùng trên môi trường thật.
- Secret nên được cấp qua environment variable hoặc secret manager, không nên
  hardcode trong file tracked.
