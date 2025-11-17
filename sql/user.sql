-- 設定資料庫連線編碼為 UTF-8 (支援中文)

-- --------------------------------------------------------
-- Table structure for "Role" (角色表)
-- --------------------------------------------------------
DROP TABLE IF EXISTS "Role" CASCADE; -- 加入 CASCADE 以防止外鍵問題
CREATE TABLE "Role" (
    "RoleID" SERIAL PRIMARY KEY, -- 移除 COMMENT
    "RoleName" VARCHAR(50) NOT NULL, -- 移除 COMMENT
    
    -- 使用 JSONB 類型，這是 PostgreSQL 中更高效的 JSON 儲存類型
    "Permissions" JSONB NULL, -- 移除 COMMENT
    
    "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    UNIQUE ("RoleName") -- UNIQUE KEY 改為 UNIQUE
);


-- --------------------------------------------------------
-- Table structure for "User" (使用者表)
-- --------------------------------------------------------
DROP TABLE IF EXISTS "User" CASCADE; -- 加入 CASCADE 以防止外鍵問題
CREATE TABLE "User" (
    "UserID" SERIAL PRIMARY KEY, -- 移除 COMMENT
    "Account" VARCHAR(50) NOT NULL, -- 移除 COMMENT
    "PasswordHash" VARCHAR(255) NOT NULL, -- 移除 COMMENT
    "UserName" VARCHAR(100) NOT NULL, -- 移除 COMMENT
    "Email" VARCHAR(100) NULL, -- 移除 COMMENT
    "Phone" VARCHAR(20) NULL, -- 移除 COMMENT
    "DeptID" INT NULL, -- 移除 COMMENT
    "RoleID" INT NULL, -- 移除 COMMENT
    "Status" INT NOT NULL DEFAULT 1, -- 移除 COMMENT
    "LastLogin" TIMESTAMP NULL, -- 移除 COMMENT
    
    UNIQUE ("Account"), -- UNIQUE KEY 改為 UNIQUE
    UNIQUE ("Email"), -- UNIQUE KEY 改為 UNIQUE
    
    -- 外鍵約束 1: 關聯 Role 表
    CONSTRAINT "fk_user_role"
        FOREIGN KEY ("RoleID") 
        REFERENCES "Role" ("RoleID") 
        ON DELETE SET NULL ON UPDATE CASCADE
        
    -- 外鍵約束 2: 關聯 Department 表 (假設存在)
    -- 注意：若 Dept 表不存在，此行會報錯，請根據您的實際情況調整。
    -- CONSTRAINT "fk_user_dept"
    --     FOREIGN KEY ("DeptID") 
    --     REFERENCES "Department" ("DeptID") 
    --     ON DELETE SET NULL ON UPDATE CASCADE
);


-- --------------------------------------------------------
-- 新增欄位註釋 (PostgreSQL 專用語法)
-- --------------------------------------------------------

-- Role Table Comments
COMMENT ON COLUMN "Role"."RoleID" IS '角色 ID';
COMMENT ON COLUMN "Role"."RoleName" IS '角色名稱 (如: 點檢員, 課長)';
COMMENT ON COLUMN "Role"."Permissions" IS '權限 (e.g., {"forms": ["read", "write"]})';

-- User Table Comments
COMMENT ON COLUMN "User"."UserID" IS '使用者 ID';
COMMENT ON COLUMN "User"."Account" IS '登入帳號';
COMMENT ON COLUMN "User"."PasswordHash" IS '雜湊後的密碼';
COMMENT ON COLUMN "User"."UserName" IS '使用者姓名';
COMMENT ON COLUMN "User"."Email" IS '電子郵件';
COMMENT ON COLUMN "User"."Phone" IS '聯絡電話';
COMMENT ON COLUMN "User"."DeptID" IS '關聯 Department.DeptID';
COMMENT ON COLUMN "User"."RoleID" IS '關聯 Role.RoleID';
COMMENT ON COLUMN "User"."Status" IS '狀態 (1:啟用, 0:停用)';
COMMENT ON COLUMN "User"."LastLogin" IS '最後登入時間';