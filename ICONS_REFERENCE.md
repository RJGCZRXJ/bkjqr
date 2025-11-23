# Element Plus 图标参考

## 问题修复记录

### ❌ 不存在的图标
以下图标在 Element Plus 图标库中不存在，已替换为可用图标：

| 原图标 | 替换图标 | 用途 |
|--------|----------|------|
| `Bold` | `Edit` | 粗体格式 |
| `Italic` | `ChatLineRound` | 斜体格式 |
| `Code` | `Document` | 代码块 |
| `Quote` | `Switch` | 引用块 |

### ✅ 已验证的可用图标

#### 常用图标
- `Edit` - 编辑
- `Document` - 文档
- `Picture` - 图片
- `Upload` - 上传
- `Link` - 链接
- `List` - 列表
- `Switch` - 切换

#### 操作图标
- `Delete` - 删除
- `Download` - 下载
- `ArrowDown` - 向下箭头
- `Plus` - 加号
- `Setting` - 设置

#### UI 状态图标
- `Moon` - 深色模式
- `Sunny` - 浅色模式
- `Menu` - 菜单
- `Microphone` - 麦克风
- `CopyDocument` - 复制
- `Refresh` - 刷新
- `Paperclip` - 附件

## 检查图标是否存在的方法

1. **查看官方文档**：https://element-plus.org/zh-CN/component/icon.html
2. **VS Code 提示**：使用 TypeScript 时会有自动补全
3. **运行时检查**：如果图标不存在，会在浏览器控制台报错

## 最佳实践

1. **使用语义化图标**：选择最接近功能的图标
2. **保持一致性**：在相似功能中使用相同图标
3. **提供文本标签**：不要只依赖图标，配合文字说明
4. **测试显示效果**：在不同主题下检查图标显示

## 修复的文件

- `src/views/PostCreateView.vue` - 博文编辑页面工具栏图标

## 注意事项

- Element Plus 图标名称使用 PascalCase
- 图标必须在 `import` 语句中导入才能使用
- 如果出现 "does not provide an export named" 错误，说明图标不存在