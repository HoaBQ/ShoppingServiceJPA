-- 1. Tạo cơ sở dữ liệu
CREATE DATABASE ShoppingServiceJPA;
GO

-- 2. Chỉ định sử dụng DB vừa tạo
USE ShoppingServiceJPA;
GO

-- 3. Tạo bảng categories (Khớp với @Table(name = "categories"))
CREATE TABLE categories (
    id INT IDENTITY(1,1) PRIMARY KEY,                 -- Đổi categoryId thành id
    category_name NVARCHAR(255) NULL,                 -- Đổi categoryname thành category_name
    icon NVARCHAR(255) NULL,                          -- Đổi images thành icon
    status INT NOT NULL DEFAULT 1
);
GO

-- 4. Tạo bảng products (Bảng mới thêm vào cho Feature sản phẩm)
CREATE TABLE products (
    id INT IDENTITY(1,1) PRIMARY KEY,
    product_name NVARCHAR(255) NULL,
    price FLOAT NOT NULL DEFAULT 0,
    description NVARCHAR(MAX) NULL,
    image NVARCHAR(255) NULL,
    quantity INT NOT NULL DEFAULT 0,
    status INT NOT NULL DEFAULT 1,
    create_date DATETIME NULL DEFAULT GETDATE(),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
);
GO

-- 5. Tạo bảng users (Đổi từ [User] thành users để khớp với @Table(name = "users"))
CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,               -- Email bắt buộc và duy nhất
    fullname NVARCHAR(255) NULL,
    phone VARCHAR(20) NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'USER',         -- Đổi roleid (INT) thành role (VARCHAR)
    is_active BIT NOT NULL DEFAULT 0,                 -- Thêm cờ kích hoạt tài khoản
    otp_code VARCHAR(10) NULL,                        -- Lưu mã OTP
    otp_expiration DATETIME NULL                      -- Lưu thời gian hết hạn OTP
);
GO

-- 6. Tạo tài khoản Admin mặc định (Đã sửa lại theo cấu trúc bảng mới)
INSERT INTO users (username, password, email, fullname, role, is_active)
VALUES ('admin', '123', 'admin@shoppingservice.com', N'Quản Trị Viên Hệ Thống', 'ADMIN', 1);
GO