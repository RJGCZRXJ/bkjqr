# Supabase 集成说明

## 项目概述

这是一个使用 Vue 3 + TypeScript + Element Plus 构建的对话机器人应用，集成了 Supabase 作为后端数据库和认证服务。

## 已完成的 Supabase 集成

### 1. 数据库配置

- **Supabase URL**: `https://ajcrzouddtnzrfnuvdxf.supabase.co`
- **环境变量配置**: 已在 `.env` 文件中正确配置
- **连接状态**: ✅ 连接成功

### 2. 数据库表结构

#### 用户相关表
- `profiles` - 用户配置文件表
- `auth.users` - Supabase 内置用户认证表

#### 应用功能表
- `ai_conversations` - AI对话记录表
- `messages` - 简单消息存储表
- `student_lists` - 学生名单管理表
- `random_selections` - 随机选择记录表
- `excel_merge_tasks` - Excel合并任务表
- `user_settings` - 用户设置表

### 3. 核心功能实现

#### 用户认证
- ✅ 用户注册 (`register()` 函数)
- ✅ 用户登录 (`login()` 函数)
- ✅ 用户登出 (`logout()` 函数)
- ✅ 认证状态管理 (`initAuth()` 函数)

#### 数据存储
- ✅ 对话记录存储 (`ai_conversations` 表)
- ✅ 消息存储 (`messages` 表)
- ✅ 本地存储备选方案

#### 数据操作
- ✅ 增删改查 (CRUD) 操作
- ✅ 行级安全策略 (RLS) 配置
- ✅ 数据类型验证

### 4. 服务文件结构

```
src/services/
├── supabaseService.ts    # Supabase 核心服务
├── deepseekService.ts    # AI 对话服务
└── ...                   # 其他服务文件
```

## 使用方法

### 1. 启动应用

```bash
# 安装依赖
npm install

# 启动开发服务器
npm run dev
```

应用将在 `http://localhost:5175/` 启动（或根据端口占用情况自动调整）

### 2. 注册新用户

1. 访问应用首页
2. 点击右上角的"注册"按钮
3. 填写邮箱、密码和用户名
4. 注册成功后自动创建用户配置文件

### 3. 使用 AI 对话功能

1. 登录后进入聊天界面
2. 输入消息与 AI 对话
3. 对话记录自动保存到 Supabase

### 4. 数据管理

#### 查看数据库
访问 Supabase Dashboard：https://app.supabase.com

#### 数据库操作
- 查看 `ai_conversations` 表：对话记录
- 查看 `profiles` 表：用户信息
- 查看 `messages` 表：简单消息

## 安全配置

### 行级安全策略 (RLS)

所有主要表都已启用 RLS：
- 用户只能访问自己的数据
- 匿名用户具有基本操作权限
- 生产环境建议配置更严格的安全策略

### API 密钥安全

- ✅ 使用环境变量存储敏感信息
- ✅ 仅使用 anon_key（前端安全）
- ⚠️ 生产环境需要配置服务端 API

## 开发指南

### 1. 添加新的数据表

```sql
-- 创建新表
CREATE TABLE new_table (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id),
  -- 其他字段...
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 启用 RLS
ALTER TABLE new_table ENABLE ROW LEVEL SECURITY;

-- 创建策略
CREATE POLICY "Users can view their own data" ON new_table
  FOR SELECT USING (auth.uid() = user_id);
```

### 2. 添加新的服务函数

在 `src/services/supabaseService.ts` 中添加：

```typescript
export async function newDataFunction(params: any): Promise<any> {
  const supabase = getSupabaseClient();
  if (!supabase) return null;
  
  try {
    const { data, error } = await supabase
      .from('new_table')
      .insert(params)
      .select('*')
      .single();
    
    if (error) {
      console.error('操作失败:', error.message);
      return null;
    }
    
    return data;
  } catch (error) {
    console.error('操作异常:', error);
    return null;
  }
}
```

### 3. 类型定义

为新的数据结构添加 TypeScript 接口：

```typescript
export interface NewTableType {
  id: string;
  user_id: string;
  // 其他字段...
  created_at: string;
  updated_at: string;
}
```

## 测试

项目包含完整的 Supabase 连接测试，验证：
- ✅ 数据库连接
- ✅ 表访问权限
- ✅ 数据增删改查
- ✅ RLS 策略生效

## 生产部署注意事项

1. **环境变量**：确保 `.env` 文件中的配置正确
2. **安全策略**：配置适当的 RLS 策略
3. **API 权限**：使用适当的 Supabase 角色和权限
4. **数据备份**：设置定期数据备份
5. **监控**：配置数据库监控和日志

## 故障排除

### 常见问题

1. **连接失败**
   - 检查 `.env` 文件中的 URL 和 Key
   - 确认 Supabase 项目状态

2. **权限错误**
   - 检查 RLS 策略配置
   - 验证用户认证状态

3. **数据类型错误**
   - 检查 TypeScript 类型定义
   - 验证数据库表结构

## 联系支持

如有问题，请检查：
1. Supabase Dashboard 中的项目状态
2. 浏览器控制台错误日志
3. 网络连接和防火墙设置