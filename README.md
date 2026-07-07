# 个人主页模板

仿照 [fangyinfff.github.io](https://fangyinfff.github.io/) 风格的个人学术主页。纯静态 HTML + CSS，无需任何框架或构建工具，托管在 GitHub Pages 上免费且零运维。

---

## 📁 目录结构

```
个人主页/
├── index.html                       # 页面主体（你改这个就行）
├── stylesheet.css                   # 样式（颜色/字体/布局，统一在这里改）
├── make-thumbnails.sh               # 把论文 PDF 首页转成 PNG 缩略图的脚本
├── .gitignore
├── images/
│   ├── portrait.svg                 # 头像占位（换成 portrait.jpg 等你的照片）
│   └── paper-first-pages/
│       └── paper-placeholder.svg    # 论文缩略图占位
├── cv/
│   └── (把你的 CV.pdf 放这里)
└── papers/                          # 可选：放论文 PDF 源文件，用于生成缩略图
    └── (your_paper.pdf)
```

---

## ✏️ 第一步：改内容（编辑 `index.html`）

打开 `index.html`，搜索并替换下面这些占位内容：

| 占位符 | 改成 |
|--------|------|
| `Your Name` / `Your Name, Ph.D.` | 你的名字 |
| `Your Role` / `Your Institution` | 你的职位 / 单位 |
| `Your Field` / `Your University` | 你的专业 / 学校 |
| `Advisor One/Two/Three` | 导师名字（记得把对应 `<a href="#">` 链接也改了） |
| `your research area` / `topic one/two/three` | 研究方向 |
| `Project Name` | 你在做的项目 |
| `you@example.com` / 各种社交链接 | 你的邮箱 / Google Scholar / GitHub / Twitter 等 |
| `cv/your_cv.pdf` | 你的 CV 文件路径 |
| `<title>Your Name</title>` 和 meta description | 同步改 |

**论文卡片**：每篇论文是一个 `<a class="paper-sheet" href="论文链接">...</a>` 块。复制粘贴一个块就能加一篇，改里面的：
- `paper-area`：研究方向标签（如 "Biomedical LLMs"）
- `href`：论文链接（arXiv / DOI / OpenReview）
- `<img src="images/paper-first-pages/xxx.png">`：论文首页缩略图
- `<h3>`：标题
- `<p>`：作者列表，**把自己名字用 `<strong>` 包起来**（加粗），等贡献用 `*`
- `paper-venue`：期刊/会议 + 年份

> 想高亮某篇论文，给它的 `<a>` 加上 `paper-sheet-featured` 类（边框会更突出）。

**头像**：把你的照片放到 `images/portrait.jpg`，然后把 `index.html` 里的 `portrait.svg` 改成 `portrait.jpg`。建议尺寸约 178×224（4:5 竖图）。

**时间线**：照片下方 `.timeline-item` 块，每个一行 `<span>年份</span> 描述`。

**页脚**：`index.html` 最底部 `Your Name · Your Institution · Updated July 2026` 改成你的，每次更新记得改日期。

---

## 🎨 改外观（编辑 `stylesheet.css`）

所有颜色都在 `stylesheet.css` 顶部的 `:root { ... }`（浅色）和 `[data-theme="dark"] { ... }`（深色）里。改这几个变量就能换主题色：

```css
--bg: #f8fcff;        /* 页面背景 */
--surface: #ffffff;   /* 卡片背景 */
--text: #172433;      /* 正文 */
--link: #2f6fa7;      /* 链接（主色） */
--accent: #6bbfe3;    /* 卡片顶部彩条、时间线圆点 */
```

字体用的是 **DM Sans**（正文）+ **DM Serif Display**（名字、章节标题），从 Google Fonts 在线加载，不用本地安装。想换字体改 `<head>` 里的 Google Fonts 链接和 CSS 里的 `font-family`。

深色/浅色切换按钮在右上角，会用 `localStorage` 记住你的选择，下次访问保持。

---

## 🖼️ 生成论文缩略图

每篇论文卡片需要一张「论文首页」的 PNG 缩略图。两种方式：

**方式 A：脚本批量生成（推荐）**

1. 装依赖（macOS）：`brew install imagemagick ghostscript`
2. 把论文 PDF 放进 `papers/` 文件夹
3. 运行：`./make-thumbnails.sh`
4. 脚本会把每篇 PDF 的首页转成 `images/paper-first-pages/<文件名>.png`
5. 在 `index.html` 里把对应 `<img src>` 改成生成的文件名

**方式 B：手动**

用截图工具截论文首页，存成 PNG 放进 `images/paper-first-pages/`，宽高比尽量接近 0.76（A4 比例）。

---

## 👀 本地预览

在项目目录下任选一种：

```bash
# 方式 1：Python（macOS 自带）
python3 -m http.server 8000
# 然后浏览器打开 http://localhost:8000

# 方式 2：Node
npx serve
```

直接双击 `index.html` 也能开，但有些浏览器对本地文件加载 Google 字体有限制，建议用上面的本地服务器。

---

## 🚀 第二步：发布到 GitHub Pages（你的 `xxx.github.io`）

GitHub Pages 的规则：**建一个名为 `<你的用户名>.github.io` 的仓库，把网页文件推上去，几分钟内自动上线。** 比如你的 GitHub 用户名是 `zhangsan`，仓库名就必须是 `zhangsan.github.io`，最终网址就是 `https://zhangsan.github.io/`。

### 0. 前置：装好 git，注册好 GitHub 账号

```bash
git --version        # 检查 git
gh auth status       # 如果装了 GitHub CLI，先登录
```

### 1. 在 GitHub 上创建仓库

- 登录 [github.com](https://github.com) → 右上角 **+** → **New repository**
- Repository name 填：**`<你的用户名>.github.io`**（必须严格一致，全小写）
- 选 **Public**（私有仓库的 GitHub Pages 需要付费 Pro，公开免费）
- **不要**勾选 "Add a README" / "Add .gitignore" / license（保持仓库空，避免冲突）
- 点 **Create repository**

### 2. 把本地项目推到这个仓库

在项目目录 `/tmp/personal-homepage`（或你挪到的位置）下执行：

```bash
cd /tmp/personal-homepage   # 换成你实际放项目的路径

# 初始化 git
git init
git branch -M main

# 把你的 GitHub 用户名填进来（替换 zhangsan）
git remote add origin https://github.com/zhangsan/zhangsan.github.io.git

git add .
git commit -m "init personal homepage"
git push -u origin main
```

第一次 push 会让你认证。用 GitHub CLI 的话先 `gh auth login`；用 HTTPS 的话用 Personal Access Token 当密码（GitHub 已不支持账号密码）。

### 3. 开启 GitHub Pages

新仓库默认就开启了，但确认一下：

- 进入仓库页面 → **Settings** → 左侧 **Pages**
- **Build and deployment** → **Source** 选 **Deploy from a branch**
- **Branch** 选 `main`，文件夹选 `/ (root)`，点 **Save**

等 1~2 分钟，刷新 Pages 设置页，顶部会出现 **"Your site is live at https://zhangsan.github.io/"**。

> ⚠️ 如果仓库不是 `<用户名>.github.io` 这种格式（比如叫 `my-homepage`），那网址会是 `https://zhangsan.github.io/my-homepage/`，而且页面里的相对路径可能需要调整。所以**强烈建议用 `<用户名>.github.io` 这个特殊仓库名**。

### 4. 以后更新内容

```bash
# 改完 index.html / 加了新论文图之后：
git add .
git commit -m "add new paper / update bio"
git push
```

push 之后 1~2 分钟 GitHub 会自动重新部署，刷新网页就能看到。

---

## 🔧 常见问题

**Q: 网址打开是 404？**
A: 等 2 分钟；确认仓库名是 `<用户名>.github.io` 且为 Public；确认 Pages 里 Branch 选了 `main`；确认根目录有 `index.html`。

**Q: 图片显示不出来？**
A: 检查 `index.html` 里的 `src` 路径和实际文件路径大小写是否完全一致（GitHub Pages 区分大小写）。`images/portrait.svg` 就得是 `images/portrait.svg`。

**Q: Google 字体加载慢 / 在国内打不开？**
A: 可以把字体下载到本地，或换成系统字体。把 `<head>` 里两行 `<link href="https://fonts.googleapis.com...">` 删掉，CSS 里 `font-family` 改成 `"PingFang SC", "Helvetica Neue", Arial, sans-serif` 即可。中文字体建议加 `"PingFang SC"`。

**Q: 想加更多章节（News / Education / Projects）？**
A: 在 `index.html` 的 `.home-main` 里复制一个 `<section>` 块，套用 `paper-deck` 的标题样式即可。保持单列居中布局最省事。

**Q: 想绑定自己的域名（如 `yourname.com`）？**
A: 仓库根目录加一个 `CNAME` 文件（内容就一行你的域名），再去域名 DNS 配置一条 CNAME 记录指向 `zhangsan.github.io`。GitHub Pages 设置页会显示 DNS 配置说明。

---

## 📐 技术说明

- 单文件 HTML + 单文件 CSS，无构建步骤、无依赖
- 响应式：桌面 3 列论文网格 → 平板 2 列 → 手机 1 列，照片在手机上自动移到文字上方
- 深/浅色模式：跟随系统偏好首次访问，右上角按钮手动切换并存 `localStorage`
- 字体：DM Sans（正文）+ DM Serif Display（标题），Google Fonts CDN
- 所有图片用相对路径，便于直接托管

参考站点：[fangyinfff.github.io](https://fangyinfff.github.io/)（结构/配色/字体方案一致，内容为占位）
