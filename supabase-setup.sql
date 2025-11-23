-- Supabase 数据库设置脚本
-- 请在Supabase项目的SQL编辑器中运行此脚本

-- 创建消息表
CREATE TABLE messages (
  id TEXT PRIMARY KEY,
  content TEXT NOT NULL,
  role TEXT NOT NULL CHECK (role IN ('user', 'bot')),
  timestamp TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 创建索引以提高查询性能
CREATE INDEX idx_messages_timestamp ON messages(timestamp);

-- 可选：添加用户标识字段（如果需要多用户支持）
-- ALTER TABLE messages ADD COLUMN user_id TEXT REFERENCES auth.users(id);
-- CREATE INDEX idx_messages_user_id ON messages(user_id);

-- 设置行级安全性（如果需要）
-- 启用行级安全性
-- ALTER TABLE messages ENABLE ROW LEVEL SECURITY;

-- 创建策略（允许用户只能访问自己的消息）
-- CREATE POLICY "Users can access their own messages" ON messages
--   USING (auth.uid() = user_id);

-- 创建策略（允许所有用户读取所有消息）
-- CREATE POLICY "All users can read messages" ON messages
--   FOR SELECT USING (true);

-- 创建策略（允许所有用户插入消息）
-- CREATE POLICY "All users can insert messages" ON messages
--   FOR INSERT WITH CHECK (true);

-- 说明：
-- 1. 此脚本创建了基本的消息表结构，用于存储聊天记录
-- 2. 默认配置下，不需要用户认证即可使用
-- 3. 如果需要多用户支持，请取消注释相关的列和策略
-- 4. 建议在生产环境中启用适当的行级安全性
-- 5. 在.env文件中配置SUPABASE_URL和SUPABASE_ANON_KEY后，应用将自动连接到Supabase
-- 6. 如果不配置Supabase，应用将自动回退到使用浏览器本地存储