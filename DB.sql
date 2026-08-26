-- 1. Tạo cơ sở dữ liệu
CREATE DATABASE ShoppingServiceJPA;
GO

-- 2. Chỉ định sử dụng DB vừa tạo
USE ShoppingServiceJPA;
GO

-- 3. Tạo bảng categories
CREATE TABLE categories (
    categoryId INT IDENTITY(1,1) PRIMARY KEY,
    categoryname NVARCHAR(255) NULL,
    images NVARCHAR(255) NULL,
    status INT NOT NULL DEFAULT 1
);
GO

-- 4. Tạo bảng videos
CREATE TABLE videos (
    videoId VARCHAR(50) PRIMARY KEY,
    title NVARCHAR(255) NULL,
    poster NVARCHAR(255) NULL,
    description NVARCHAR(MAX) NULL,
    active BIT NOT NULL DEFAULT 1,
    views INT NOT NULL DEFAULT 0,
    categoryId INT,
    FOREIGN KEY (categoryId) REFERENCES categories(categoryId) ON DELETE SET NULL
);
GO

-- 5. Tạo bảng User
CREATE TABLE [User] (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NULL,
    fullname NVARCHAR(100) NULL,
    phone VARCHAR(20) NULL,
    avatar VARCHAR(255) NULL,
    roleid INT NOT NULL DEFAULT 2, -- 1: Admin, 2: User
    createddate DATE NULL
);
GO

-- 6. Tạo tài khoản Admin mặc định (QUAN TRỌNG ĐỂ LOGIN)
INSERT INTO [User] (username, password, email, fullname, roleid, createddate)
VALUES ('admin', '123', 'admin@shoppingservice.com', N'Quản Trị Viên Hệ Thống', 1, GETDATE());
GO

